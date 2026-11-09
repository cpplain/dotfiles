function cd_worktree --description "Fuzzy-pick a git worktree and cd into it"
    set -l options h/help r/repo=
    if not argparse $options -- $argv
        return 1
    end

    if set -q _flag_help
        echo "Usage: cd_worktree [--repo|-r <path>] [query]"
        echo "Examples:"
        echo "  cd_worktree"
        echo "  cd_worktree widget"
        echo "  cd_worktree --repo ~/git/work/myrepo"
        return 1
    end

    set -l lookup .
    if set -q _flag_repo
        set lookup $_flag_repo
    end

    set -l paths (git -C $lookup worktree list --porcelain 2>/dev/null | string replace -rf '^worktree ' '')
    or begin
        echo "Error: Not in a git repository"
        return 1
    end

    set -l target (printf '%s\n' $paths | fzf --height 40% --reverse --select-1 --exit-0 --query "$argv")
    or return 1

    cd $target
end
