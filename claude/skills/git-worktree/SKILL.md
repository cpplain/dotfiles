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

Worktrees use `{repo-name}-{branch-basename}` always created in `~/git/`:

```
~/git/
├── work/
│   └── myrepo/                # main worktree (nested)
├── myrepo-feature-widget/     # worktree for feature/widget
└── myrepo-JIRA-123/           # worktree for scratch/JIRA-123
```

## Usage

Run scripts from within any git repository, or pass `--repo` to specify a repo path:

```bash
# Create worktree (handles existing local, remote, or creates new branch)
/path/to/skills/git-worktree/scripts/add-worktree.sh feature/new-widget

# Create worktree for a repo at an arbitrary path
/path/to/skills/git-worktree/scripts/add-worktree.sh --repo ~/git/work/myrepo feature/new-widget

# Create worktree and copy files from main
/path/to/skills/git-worktree/scripts/add-worktree.sh feature/widget --copy .env config/local.yaml

# Remove worktree by name (not branch name)
/path/to/skills/git-worktree/scripts/remove-worktree.sh myrepo-feature-widget

# Remove worktree for a repo at an arbitrary path
/path/to/skills/git-worktree/scripts/remove-worktree.sh --repo ~/git/work/myrepo myrepo-feature-widget

# List worktrees
git worktree list
```

## Notes

- Branch `feature/new-widget` creates worktree named `{repo}-new-widget` (uses basename)
- Worktrees are always created in `~/git/` regardless of where the source repo lives
- Scripts check for existing local branch, then remote, then create new
- Use `git worktree remove --force <path>` if uncommitted changes block removal
