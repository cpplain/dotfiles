function add_worktree --description "Add a git worktree with standardized naming"
    set -l options h/help c/copy r/repo=
    if not argparse $options -- $argv
        return 1
    end

    if set -q _flag_help; or test (count $argv) -eq 0
        echo "Usage: add_worktree [--repo|-r <path>] <branch-name> [--copy|-c file1 file2 ...]"
        echo "Worktrees are created at ~/git/worktrees/<repo>/<branch>"
        echo "Examples:"
        echo "  add_worktree feature/new-widget"
        echo "  add_worktree --repo ~/git/work/myrepo feature/new-widget"
        echo "  add_worktree scratch/JIRA-123 --copy .env config/"
        echo "  add_worktree bugfix/login-issue -c .env package-lock.json"
        return 1
    end

    if set -q _flag_repo
        set copy_root (git -C "$_flag_repo" rev-parse --show-toplevel 2>/dev/null)
        or begin
            echo "Error: Not a git repository: $_flag_repo"
            return 1
        end
    else
        set copy_root (git rev-parse --show-toplevel 2>/dev/null)
        or begin
            echo "Error: Not in a git repository"
            return 1
        end
    end

    # Name after the main clone, even when invoked from a linked worktree.
    set git_common (git -C $copy_root rev-parse --path-format=absolute --git-common-dir)
    set repo_root (dirname $git_common)
    set repo_name (basename $repo_root)
    set worktrees_dir ~/git/worktrees

    set branch_name $argv[1]
    if test -z "$branch_name"; or string match -q '/*' $branch_name; or string match -q '*..*' $branch_name
        echo "Error: Invalid branch name: $branch_name"
        return 1
    end

    set -l files_to_copy
    if set -q _flag_copy
        if test (count $argv) -gt 1
            set files_to_copy $argv[2..-1]
        end
    end

    set worktree_path "$worktrees_dir/$repo_name/$branch_name"

    echo "Creating worktree:"
    echo "  Repository: $repo_name"
    echo "  Branch: $branch_name"
    echo "  Worktree path: $worktree_path"

    mkdir -p (dirname $worktree_path)
    or begin
        echo "Error: Failed to create worktree directory"
        return 1
    end

    if git -C $repo_root show-ref --verify --quiet "refs/heads/$branch_name"
        echo "Using existing local branch: $branch_name"
        git -C $repo_root worktree add $worktree_path $branch_name
    else if git -C $repo_root ls-remote --heads origin $branch_name 2>/dev/null | grep -q .
        echo "Checking out remote branch: origin/$branch_name"
        git -C $repo_root worktree add $worktree_path $branch_name
    else
        echo "Creating new branch: $branch_name"
        git -C $repo_root worktree add -b $branch_name $worktree_path
    end

    if test $status -ne 0
        echo "Error: Failed to create worktree"
        return 1
    end

    echo "Worktree created successfully!"
    echo "To navigate to it: cd $worktree_path"
    echo "To remove it later: remove_worktree $worktree_path"

    if test -n "$files_to_copy"
        echo ""
        echo "Copying files to new worktree..."

        for file in $files_to_copy
            set src_path "$copy_root/$file"
            set dest_path "$worktree_path/$file"

            if test -e "$src_path"
                set parent (dirname "$dest_path")
                if not test -d "$parent"
                    mkdir -p "$parent"
                end

                if test -d "$src_path"
                    cp -R "$src_path" "$dest_path"
                    echo "  Copied directory: $file"
                else
                    cp "$src_path" "$dest_path"
                    echo "  Copied file: $file"
                end
            else
                echo "  Warning: $file not found, skipping"
            end
        end
    end
end
