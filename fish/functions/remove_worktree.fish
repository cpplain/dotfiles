function remove_worktree --description "Remove a git worktree"
    set -l options h/help r/repo=
    if not argparse $options -- $argv
        return 1
    end

    if set -q _flag_help; or test (count $argv) -eq 0
        echo "Usage: remove_worktree [--repo|-r <path>] <worktree-name-or-path>"
        echo "Examples:"
        echo "  remove_worktree feature/new-widget"
        echo "  remove_worktree ~/git/worktrees/myrepo/feature/new-widget"
        echo "  remove_worktree --repo ~/git/work/myrepo feature/new-widget"
        return 1
    end

    set query $argv[1]
    if test -d $query
        set query (path resolve $query)
    end

    if set -q _flag_repo
        set lookup $_flag_repo
    else if test -d $query
        set lookup $query
    else
        set lookup .
    end

    set repo_root (git -C $lookup rev-parse --show-toplevel 2>/dev/null)
    or begin
        if set -q _flag_repo
            echo "Error: Not a git repository: $_flag_repo"
        else if test -d $query
            echo "Error: Not a git worktree: $query"
        else
            echo "Error: Not in a git repository"
        end
        return 1
    end

    set git_common (git -C $repo_root rev-parse --path-format=absolute --git-common-dir)
    set main_root (dirname $git_common)
    set repo_name (basename $main_root)
    set prefix ~/git/worktrees/$repo_name/

    set -l matches
    set main_worktree ""
    set -l available

    for line in (git -C $repo_root worktree list --porcelain | grep "^worktree ")
        set path (string replace "worktree " "" $line)

        if test -d "$path/.git"
            set main_worktree $path
        end

        if test "$path" != "$main_worktree"
            if string match -q -- "$prefix*" $path
                set -a available (string replace -- $prefix "" $path)
            else
                set -a available $path
            end
        end

        if test "$path" = "$query"; or string match -q -- "*/$query" $path
            set -a matches $path
        end
    end

    if test -z "$main_worktree"
        echo "Error: Could not find main worktree"
        return 1
    end

    if test (count $matches) -eq 0
        echo "Error: Worktree '$argv[1]' not found"
        if test (count $available) -gt 0
            echo "Available worktrees:"
            for name in $available
                echo "  - $name"
            end
        end
        return 1
    end

    if test (count $matches) -gt 1
        echo "Error: '$argv[1]' matches multiple worktrees:"
        for path in $matches
            echo "  - $path"
        end
        return 1
    end

    set target_worktree $matches[1]

    if test "$target_worktree" = "$main_worktree"
        echo "Error: Cannot remove main worktree"
        return 1
    end

    echo "Removing worktree..."
    git -C $repo_root worktree remove $target_worktree
    if test $status -ne 0
        echo "Error: Failed to remove worktree"
        echo "You may need to use 'git worktree remove --force' if there are uncommitted changes"
        return 1
    end

    set parent (dirname $target_worktree)
    set stop ~/git/worktrees
    while test "$parent" != "$stop"; and test "$parent" != /; and test -d "$parent"
        rmdir $parent 2>/dev/null
        or break
        set parent (dirname $parent)
    end

    echo "Successfully removed worktree: $target_worktree"
end
