function remove_worktree --description "Remove a git worktree and its backup directory"
    set -l options h/help r/repo=
    if not argparse $options -- $argv
        return 1
    end

    if test (count $argv) -eq 0
        echo "Usage: remove_worktree [--repo|-r <path>] <worktree-name>"
        echo "Example: remove_worktree myrepo-feature-branch"
        echo "         remove_worktree --repo ~/git/work/myrepo myrepo-feature-branch"
        return 1
    end

    if set -q _flag_repo
        set repo_root (git -C "$_flag_repo" rev-parse --show-toplevel 2>/dev/null)
        or begin
            echo "Error: Not a git repository: $_flag_repo"
            return 1
        end
    else
        set repo_root (git rev-parse --show-toplevel 2>/dev/null)
        or begin
            echo "Error: Not in a git repository"
            return 1
        end
    end

    set worktree_name $argv[1]
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
