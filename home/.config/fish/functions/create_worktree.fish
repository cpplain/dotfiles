function create_worktree --description 'Create a git worktree with standardized naming'
    # Get the repository root and name
    set repo_root (git rev-parse --show-toplevel 2>/dev/null)
    or begin
        echo "Error: Not in a git repository"
        return 1
    end

    set repo_name (basename $repo_root)
    set parent_dir (dirname $repo_root)

    # Get branch name
    if test (count $argv) -eq 0
        echo "Usage: create_worktree <branch-name>"
        echo "Examples:"
        echo "  create_worktree feature/new-widget"
        echo "  create_worktree scratch/JIRA-123"
        echo "  create_worktree bugfix/login-issue"
        return 1
    end

    set branch_name $argv[1]

    # Convert slashes to hyphens for directory name
    set branch_safe (string replace -a '/' '-' $branch_name)

    # Construct worktree name
    set worktree_name "$repo_name-$branch_safe"
    set worktree_path "$parent_dir/$worktree_name"

    echo "Creating worktree:"
    echo "  Repository: $repo_name"
    echo "  Branch: $branch_name"
    echo "  Worktree path: $worktree_path"
    echo

    # Check if branch exists locally or remotely
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

    echo
    echo "Worktree created successfully!"
    echo "To navigate to it: cd $worktree_path"
end

