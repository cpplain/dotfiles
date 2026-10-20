#!/bin/sh
# Write selected servers from plugins/lsp-config/.lsp.json, or ignore the file locally.
set -eu

usage() {
    cat <<'EOF'
Usage:
  init-lsp.sh write [--dest PATH] <server> [server...]
  init-lsp.sh exclude [--repo PATH]
  init-lsp.sh catalog
EOF
}

script_path=$(realpath "$0")
catalog=$(realpath "$(dirname "$script_path")/../../../plugins/lsp-config/.lsp.json")

die() {
    printf '%s\n' "$*" >&2
    exit 1
}

cmd=${1:-}
[ -n "$cmd" ] || { usage >&2; exit 1; }
shift

case $cmd in
    catalog)
        [ -f "$catalog" ] || die "Catalog not found: $catalog"
        jq -r 'keys[]' "$catalog"
        ;;
    write)
        dest=""
        while [ $# -gt 0 ]; do
            case $1 in
                --dest)
                    dest=${2:-}
                    [ -n "$dest" ] || die "write --dest requires a path"
                    shift 2
                    ;;
                --)
                    shift
                    break
                    ;;
                -*)
                    die "unknown write flag: $1"
                    ;;
                *)
                    break
                    ;;
            esac
        done
        [ $# -gt 0 ] || die "write requires at least one server name"
        [ -f "$catalog" ] || die "Catalog not found: $catalog"

        unknown=$(jq -r --args '
            . as $all
            | $ARGS.positional
            | map(select($all[.] == null))
            | .[]
        ' "$@" <"$catalog")
        if [ -n "$unknown" ]; then
            printf 'Unknown server(s):\n%s\nKnown servers:\n' "$unknown" >&2
            jq -r 'keys[]' "$catalog" >&2
            exit 1
        fi

        json=$(jq --args '
            . as $all
            | $ARGS.positional
            | map({key: ., value: $all[.]})
            | from_entries
        ' "$@" <"$catalog")

        if [ -z "$dest" ]; then
            dest=$(git rev-parse --show-toplevel)/.grok/lsp.json
        fi
        mkdir -p "$(dirname "$dest")"
        printf '%s\n' "$json" | jq '.' >"$dest"
        printf 'Wrote %s\n' "$dest"
        ;;
    exclude)
        repo="."
        while [ $# -gt 0 ]; do
            case $1 in
                --repo)
                    repo=${2:-}
                    [ -n "$repo" ] || die "exclude --repo requires a path"
                    shift 2
                    ;;
                *)
                    die "unknown exclude flag: $1"
                    ;;
            esac
        done
        git -C "$repo" rev-parse --is-inside-work-tree >/dev/null 2>&1 \
            || die "Not a git repository: $repo"

        if git -C "$repo" check-ignore -q .grok/lsp.json; then
            printf '.grok/lsp.json already ignored\n'
            exit 0
        fi

        common=$(git -C "$repo" rev-parse --path-format=absolute --git-common-dir)
        exclude="$common/info/exclude"
        mkdir -p "$(dirname "$exclude")"
        if [ -f "$exclude" ] && grep -qxF '.grok/lsp.json' "$exclude"; then
            printf '.grok/lsp.json already in %s\n' "$exclude"
            exit 0
        fi
        printf '%s\n' '.grok/lsp.json' >>"$exclude"
        printf 'Added .grok/lsp.json to %s\n' "$exclude"
        ;;
    -h|--help|help)
        usage
        ;;
    *)
        usage >&2
        exit 1
        ;;
esac
