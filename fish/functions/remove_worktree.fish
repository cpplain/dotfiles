function remove_worktree --description "Remove a git worktree and its backup directory"
    set -l options h/help
    if not argparse $options -- $argv
        return 1
    end

    if test (count $argv) -eq 0
        echo "Usage: remove_worktree <worktree-name-or-path>"
        echo "Example: remove_worktree myrepo-feature-branch"
        echo "         remove_worktree ~/git/worktrees/myrepo-feature-branch"
        return 1
    end

    if test -d "$argv[1]"
        set repo_root (git -C "$argv[1]" rev-parse --show-toplevel 2>/dev/null)
        or begin
            echo "Error: Not a git worktree: $argv[1]"
            return 1
        end
        set worktree_name (basename "$argv[1]")
    else
        set repo_root (git rev-parse --show-toplevel 2>/dev/null)
        or begin
            echo "Error: Not in a git repository"
            return 1
        end
        set worktree_name $argv[1]
    end
    set target_worktree ""
    set main_worktree ""

    for line in (git -C $repo_root worktree list --porcelain | grep "^worktree ")
        set path (string replace "worktree " "" $line)
        set name (basename $path)

        if test -d "$path/.git"
            set main_worktree $path
        end

        if test "$name" = "$worktree_name"
            set target_worktree $path
        end
    end

    if test -z "$main_worktree"
        echo "Error: Could not find main worktree"
        return 1
    end

    if test -z "$target_worktree"
        echo "Error: Worktree '$worktree_name' not found"
        echo "Available worktrees:"
        for line in (git -C $repo_root worktree list --porcelain | grep "^worktree ")
            set path (string replace "worktree " "" $line)
            echo "  - "(basename $path)
        end
        return 1
    end

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

    echo "Successfully removed worktree: $worktree_name"
end
