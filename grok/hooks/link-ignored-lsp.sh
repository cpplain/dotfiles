#!/bin/sh
# Link the main clone's ignored .grok/lsp.json into this worktree.
root=${1:-${GROK_WORKSPACE_ROOT:-$PWD}}

git -C "$root" rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0
git -C "$root" check-ignore -q .grok/lsp.json || exit 0

if [ -e "$root/.grok/lsp.json" ]; then
    exit 0
fi
# Replace a leftover broken symlink.
if [ -L "$root/.grok/lsp.json" ]; then
    rm -f "$root/.grok/lsp.json"
fi

common=$(git -C "$root" rev-parse --path-format=absolute --git-common-dir) || exit 0
src="$(dirname "$common")/.grok/lsp.json"
[ -f "$src" ] || exit 0
[ "$src" = "$root/.grok/lsp.json" ] && exit 0

mkdir -p "$root/.grok"
ln -sfn "$src" "$root/.grok/lsp.json"
echo "Linked .grok/lsp.json -> $src"
