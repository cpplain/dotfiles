function add_worktree --description "Add a git worktree with standardized naming"
    set repo_root (git rev-parse --show-toplevel 2>/dev/null)
    or begin
        echo "Error: Not in a git repository"
        return 1
    end

    set repo_name (basename $repo_root)
    set parent_dir (dirname $repo_root)

    if test (count $argv) -eq 0
        echo "Usage: add_worktree <branch-name>"
        echo "Examples:"
        echo "  add_worktree feature/new-widget"
        echo "  add_worktree scratch/JIRA-123"
        echo "  add_worktree bugfix/login-issue"
        return 1
    end

    set branch_name $argv[1]
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

    echo "Worktree created successfully!"
    echo "To navigate to it: cd $worktree_path"
    echo "To remove it later: remove_worktree $worktree_name"

    cd $worktree_path
    sync_worktree_files
    cd - >/dev/null
end
