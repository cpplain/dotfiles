---
name: git-worktree
description: Git worktree management with standardized naming. Use when managing git worktrees, creating feature branches in separate directories, or copying files between worktrees.
---

# Git Worktree Management

## Scripts

| Script                       | Purpose                                  |
| ---------------------------- | ---------------------------------------- |
| `scripts/add-worktree.sh`    | Create worktree with standardized naming |
| `scripts/remove-worktree.sh` | Remove worktree by name                  |

## Naming Convention

Worktrees use `{repo-name}-{branch-basename}` in the repo's parent directory:

```
~/projects/
├── myrepo/                    # main worktree
├── myrepo-feature-widget/     # worktree for feature/widget
└── myrepo-JIRA-123/           # worktree for scratch/JIRA-123
```

## Usage

Run scripts from within any git repository:

```bash
# Create worktree (handles existing local, remote, or creates new branch)
/path/to/skills/git-worktree/scripts/add-worktree.sh feature/new-widget

# Create worktree and copy files from main
/path/to/skills/git-worktree/scripts/add-worktree.sh feature/widget --copy .env config/local.yaml

# Remove worktree by name (not branch name)
/path/to/skills/git-worktree/scripts/remove-worktree.sh myrepo-feature-widget

# List worktrees
git worktree list
```

## Notes

- Branch `feature/new-widget` creates worktree named `{repo}-new-widget` (uses basename)
- Scripts check for existing local branch, then remote, then create new
- Use `git worktree remove --force <path>` if uncommitted changes block removal
