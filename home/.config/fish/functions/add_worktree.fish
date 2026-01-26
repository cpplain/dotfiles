function add_worktree --description "Add a git worktree with standardized naming"
    set repo_root (git rev-parse --show-toplevel 2>/dev/null)
    or begin
        echo "Error: Not in a git repository"
        return 1
    end

    set repo_name (basename $repo_root)
    set parent_dir (dirname $repo_root)

    # Parse arguments
    set -l options h/help c/copy
    if not argparse $options -- $argv
        return 1
    end

    if set -q _flag_help; or test (count $argv) -eq 0
        echo "Usage: add_worktree <branch-name> [--copy|-c file1 file2 ...]"
        echo "Examples:"
        echo "  add_worktree feature/new-widget"
        echo "  add_worktree scratch/JIRA-123 --copy .env config/"
        echo "  add_worktree bugfix/login-issue -c .env package-lock.json"
        return 1
    end

    set branch_name $argv[1]

    # Collect files to copy if --copy flag is used
    set -l files_to_copy
    if set -q _flag_copy
        # All remaining arguments after the branch name are files to copy
        if test (count $argv) -gt 1
            set files_to_copy $argv[2..-1]
        end
    end
    set branch_base (basename $branch_name)
    set worktree_name "$repo_name-$branch_base"
    set worktree_path "$parent_dir/$worktree_name"

    echo "Creating worktree:"
    echo "  Repository: $repo_name"
    echo "  Branch: $branch_name"
    echo "  Worktree path: $worktree_path"

    if git show-ref --verify --quiet "refs/heads/$branch_name"
        echo "Using existing local branch: $branch_name"
        git worktree add $worktree_path $branch_name
    else if git ls-remote --heads origin $branch_name | grep -q .
        echo "Checking out remote branch: origin/$branch_name"
        git worktree add $worktree_path $branch_name
    else
        echo "Creating new branch: $branch_name"
        git worktree add -b $branch_name $worktree_path
    end

    if test $status -ne 0
        echo "Error: Failed to create worktree"
        return 1
    end

    echo "Worktree created successfully!"
    echo "To navigate to it: cd $worktree_path"
    echo "To remove it later: remove_worktree $worktree_name"

    # Copy specified files from current directory to new worktree
    if test -n "$files_to_copy"
        echo ""
        echo "Copying files to new worktree..."

        for file in $files_to_copy
            set src_path "$repo_root/$file"
            set dest_path "$worktree_path/$file"

            if test -e "$src_path"
                # Create parent directory if needed
                set parent (dirname "$dest_path")
                if not test -d "$parent"
                    mkdir -p "$parent"
                end

                # Copy the file or directory
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
