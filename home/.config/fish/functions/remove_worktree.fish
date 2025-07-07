function remove_worktree --description "Remove a git worktree and its backup directory"
    if test (count $argv) -eq 0
        echo "Usage: remove_worktree <worktree-name>"
        echo "Example: remove_worktree myrepo-feature-branch"
        return 1
    end

    set worktree_name $argv[1]
    set target_worktree ""
    set main_worktree ""

    for line in (git worktree list --porcelain | grep "^worktree ")
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
        for line in (git worktree list --porcelain | grep "^worktree ")
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
    git worktree remove $target_worktree
    if test $status -ne 0
        echo "Error: Failed to remove worktree"
        echo "You may need to use 'git worktree remove --force' if there are uncommitted changes"
        return 1
    end

    echo "Successfully removed worktree: $worktree_name"
end
