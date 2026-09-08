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

Worktrees are created at `~/git/worktrees/<repo>/<branch>`. Main clones stay where they are. Branch slashes become nested directories:

```
~/git/
├── work/
│   └── myrepo/                              # main clone
├── dotfiles/                                # main clone
└── worktrees/
    ├── myrepo/
    │   └── feature/
    │       └── widget/                      # worktree for feature/widget
    └── dotfiles/
        └── scratch/
            └── JIRA-123/                    # worktree for scratch/JIRA-123
```

## Usage

Run scripts from within any git repository, or pass `--repo` to specify a repo path:

```bash
# Create worktree (handles existing local, remote, or creates new branch)
/path/to/skills/git-worktree/scripts/add-worktree.sh feature/new-widget

# Create worktree for a repo at an arbitrary path
/path/to/skills/git-worktree/scripts/add-worktree.sh --repo ~/git/work/myrepo feature/new-widget

# Create worktree and copy files from the current tree
/path/to/skills/git-worktree/scripts/add-worktree.sh feature/widget --copy .env config/local.yaml

# Remove worktree by branch path (from inside the repo) or by filesystem path
/path/to/skills/git-worktree/scripts/remove-worktree.sh feature/new-widget
/path/to/skills/git-worktree/scripts/remove-worktree.sh ~/git/worktrees/myrepo/feature/new-widget

# Remove worktree for a repo at an arbitrary path
/path/to/skills/git-worktree/scripts/remove-worktree.sh --repo ~/git/work/myrepo feature/new-widget

# List worktrees
git worktree list
```

## Notes

- Branch `feature/new-widget` creates `~/git/worktrees/<repo>/feature/new-widget`
- Worktrees are always created under `~/git/worktrees/` regardless of where the source repo lives
- Repo name comes from the main clone, even when the command is run from a linked worktree
- Scripts check for existing local branch, then remote, then create new
- Use `git worktree remove --force <path>` if uncommitted changes block removal
- Relocate an existing worktree with `git worktree move <path> ~/git/worktrees/<repo>/<branch>`
