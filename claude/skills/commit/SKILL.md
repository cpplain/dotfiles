---
name: commit
description: >-
  Creates git commits following Conventional Commits, or the repo's own
  commit convention when one exists. Use when the user asks to commit,
  stage changes, write or fix a commit message, or amend a commit.
allowed-tools: Bash(git status *) Bash(git diff *) Bash(git log *) Bash(git add *) Bash(git commit *)
metadata:
  author: cpplain
  version: "1.5"
---

# Commit

Create commits following [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/), unless the repo specifies another format.

## Current State

```!
git status --short
git diff --staged --stat
git log --oneline -5 || true
```

## Check for Repo-Specific Format

Before composing a commit message, check for overriding conventions:

1. `commitlint.config.*`, `.commitlintrc*`, or a `commitlint` key in `package.json` (commitlint rules)
2. `.gitmessage` (commit template)
3. `commit-msg` hooks in `.husky/` or `lefthook.yml`
4. `CONTRIBUTING.md` (commit guidelines section)

If found, follow the repo's format instead.

## Commit Message Format

```
<type>[(<scope>)][!]: <description>

[optional body]

[optional footer(s)]
```

The spec defines this structure, `feat`, `fix`, and breaking changes. The other types and the style rules below are common conventions (types and description style: Angular, commitlint `config-conventional`; 72-character lines: git convention); repo rules take precedence.

### Types

| Type       | Purpose                                                 |
| ---------- | ------------------------------------------------------- |
| `feat`     | New feature                                             |
| `fix`      | Bug fix                                                 |
| `docs`     | Documentation only                                      |
| `style`    | Formatting, whitespace (not CSS)                        |
| `refactor` | Code change that neither fixes a bug nor adds a feature |
| `perf`     | Performance improvement                                 |
| `test`     | Adding or updating tests                                |
| `build`    | Build system or external dependencies                   |
| `ci`       | CI configuration and scripts                            |
| `chore`    | Other changes that don't modify src or test files       |
| `revert`   | Reverts a previous commit; add `Refs: <sha>` footer     |

If changes span multiple types, prefer splitting them into separate commits.

### Description

- Use imperative mood ("add feature" not "added feature")
- Lowercase first letter
- No period at the end
- Keep the whole header line at 72 characters or fewer

### Scope

Module or area affected — derive from the primary area of change using singular, lowercase names (e.g., `auth`, `api`, `parser`). Omit for cross-cutting changes.

### Breaking Changes

A commit of any type can be breaking. Indicate it in either (or both) of two ways:

- Append `!` after type/scope: `feat(api)!: remove deprecated endpoints`
- Add a `BREAKING CHANGE:` footer: `BREAKING CHANGE: response format changed from XML to JSON`
- With `!` alone the footer is optional; the description must then describe the break
- `BREAKING CHANGE` must be uppercase; `BREAKING-CHANGE` is also accepted as a footer token

### Body and Footers

- Separate the body from the description, and footers from the body, with a blank line
- The body can contain multiple paragraphs separated by blank lines; wrap lines at 72 characters
- Use the body to explain **why** the change was made when the description alone isn't sufficient
- Footers use the `token: value` or `token #value` format (e.g., `Refs: #123`, `Reviewed-by: Name`)
- Footer tokens must use `-` instead of spaces (e.g., `Reviewed-by` not `Reviewed by`); `BREAKING CHANGE` is the sole exception

## Workflow

1. Review the current state above (if it was not injected, run `git status --short` and `git log --oneline -5`), then run `git diff --staged` to see what is being committed. If nothing is staged, also run `git diff`.
2. If nothing is staged, identify the relevant files and stage them with `git add <file>...` (prefer explicit paths over `git add -A`)
3. Compose the commit message following the format above, matching the scope and type style of recent commits
4. Commit using a heredoc for multi-line messages:

```bash
git commit -m "$(cat <<'EOF'
type(scope): description

Body text here.

Footer: value
EOF
)"
```

To amend, run `git commit --amend` (add `--no-edit` to keep the message) only when the user asks. If `git status` shows the branch is not ahead of its upstream, the commit is already pushed: confirm with the user before amending.
