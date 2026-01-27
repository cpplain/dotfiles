#!/usr/bin/env bash
# Remove a git worktree by name

set -euo pipefail

if [[ $# -eq 0 ]]; then
    echo "Usage: remove-worktree <worktree-name>"
    echo "Example: remove-worktree myrepo-feature-branch"
    exit 1
fi

worktree_name="$1"
target_worktree=""
main_worktree=""

# Parse worktree list to find target and main worktree
while IFS= read -r line; do
    if [[ "$line" == worktree\ * ]]; then
        path="${line#worktree }"
        name=$(basename "$path")

        # Main worktree has .git as a directory, linked worktrees have .git as a file
        if [[ -d "${path}/.git" ]]; then
            main_worktree="$path"
        fi

        if [[ "$name" == "$worktree_name" ]]; then
            target_worktree="$path"
        fi
    fi
done < <(git worktree list --porcelain)

if [[ -z "$main_worktree" ]]; then
    echo "Error: Could not find main worktree"
    exit 1
fi

if [[ -z "$target_worktree" ]]; then
    echo "Error: Worktree '$worktree_name' not found"
    echo "Available worktrees:"
    while IFS= read -r line; do
        if [[ "$line" == worktree\ * ]]; then
            path="${line#worktree }"
            echo "  - $(basename "$path")"
        fi
    done < <(git worktree list --porcelain)
    exit 1
fi

if [[ "$target_worktree" == "$main_worktree" ]]; then
    echo "Error: Cannot remove main worktree"
    exit 1
fi

echo "Removing worktree..."
if ! git worktree remove "$target_worktree"; then
    echo "Error: Failed to remove worktree"
    echo "You may need to use 'git worktree remove --force' if there are uncommitted changes"
    exit 1
fi

echo "Successfully removed worktree: $worktree_name"
