#!/usr/bin/env bash
# Add a git worktree with standardized naming

set -uo pipefail

usage() {
    echo "Usage: add-worktree <branch-name> [--copy|-c file1 file2 ...]"
    echo "Examples:"
    echo "  add-worktree feature/new-widget"
    echo "  add-worktree scratch/JIRA-123 --copy .env config/"
    echo "  add-worktree bugfix/login-issue -c .env package-lock.json"
    exit 1
}

repo_root=$(git rev-parse --show-toplevel 2>/dev/null) || {
    echo "Error: Not in a git repository"
    exit 1
}

repo_name=$(basename "$repo_root")
parent_dir=$(dirname "$repo_root")

# Parse arguments - extract flags first (like fish argparse)
copy_flag=false
positional_args=()

for arg in "$@"; do
    case "$arg" in
    -h | --help)
        usage
        ;;
    -c | --copy)
        copy_flag=true
        ;;
    *)
        positional_args+=("$arg")
        ;;
    esac
done

if [[ ${#positional_args[@]} -eq 0 ]]; then
    usage
fi

branch_name="${positional_args[0]}"

# Collect files to copy (all positional args after branch name)
files_to_copy=()
if [[ "$copy_flag" == true && ${#positional_args[@]} -gt 1 ]]; then
    files_to_copy=("${positional_args[@]:1}")
fi

branch_base=$(basename "$branch_name")
worktree_name="${repo_name}-${branch_base}"
worktree_path="${parent_dir}/${worktree_name}"

echo "Creating worktree:"
echo "  Repository: $repo_name"
echo "  Branch: $branch_name"
echo "  Worktree path: $worktree_path"

if git show-ref --verify --quiet "refs/heads/${branch_name}"; then
    echo "Using existing local branch: $branch_name"
    if ! git worktree add "$worktree_path" "$branch_name"; then
        echo "Error: Failed to create worktree"
        exit 1
    fi
elif git ls-remote --heads origin "$branch_name" 2>/dev/null | grep -q .; then
    echo "Checking out remote branch: origin/$branch_name"
    if ! git worktree add "$worktree_path" "$branch_name"; then
        echo "Error: Failed to create worktree"
        exit 1
    fi
else
    echo "Creating new branch: $branch_name"
    if ! git worktree add -b "$branch_name" "$worktree_path"; then
        echo "Error: Failed to create worktree"
        exit 1
    fi
fi

echo "Worktree created successfully!"
echo "To navigate to it: cd $worktree_path"
echo "To remove it later: remove-worktree $worktree_name"

# Copy specified files from current directory to new worktree
if [[ ${#files_to_copy[@]} -gt 0 ]]; then
    echo ""
    echo "Copying files to new worktree..."

    for file in "${files_to_copy[@]}"; do
        src_path="${repo_root}/${file}"
        dest_path="${worktree_path}/${file}"

        if [[ -e "$src_path" ]]; then
            # Create parent directory if needed
            parent=$(dirname "$dest_path")
            if [[ ! -d "$parent" ]]; then
                mkdir -p "$parent"
            fi

            # Copy the file or directory
            if [[ -d "$src_path" ]]; then
                cp -R "$src_path" "$dest_path"
                echo "  Copied directory: $file"
            else
                cp "$src_path" "$dest_path"
                echo "  Copied file: $file"
            fi
        else
            echo "  Warning: $file not found, skipping"
        fi
    done
fi
