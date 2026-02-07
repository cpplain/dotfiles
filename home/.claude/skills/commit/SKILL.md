---
name: commit
description: >-
  Create git commits following Conventional Commits. Use when committing
  changes, staging files, or creating commit messages.
allowed-tools: Bash(git:*)
metadata:
  author: cpplain
  version: "1.4"
---

# Commit

Create commits following [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/), unless the repo specifies another format.

## Check for Repo-Specific Format

Before composing a commit message, check for overriding conventions:

1. `commitlint.config.*` or `.commitlintrc*` (commitlint rules)
2. `.gitmessage` (commit template)
3. `CONTRIBUTING.md` (commit guidelines section)

If found, follow the repo's format instead.

## Commit Message Format

```
<type>[(<scope>)][!]: <description>

[optional body]

[optional footer(s)]
```

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
| `revert`   | Reverts a previous commit                               |

### Description

- Use imperative mood ("add feature" not "added feature")
- Lowercase first letter
- No period at the end

### Scope

Module or area affected — derive from the primary area of change using singular, lowercase names (e.g., `auth`, `api`, `parser`). Omit for cross-cutting changes.

### Breaking Changes

Indicate breaking changes in either (or both) of two ways:

- Append "!" after type/scope: `feat(api)!: remove deprecated endpoints`
- Add a `BREAKING CHANGE:` footer: `BREAKING CHANGE: response format changed from XML to JSON`
- `BREAKING CHANGE` must be uppercase; `BREAKING-CHANGE` is also accepted as a footer token

### Body and Footers

- Separate the body from the description with a blank line
- The body can contain multiple paragraphs separated by blank lines
- Use the body to explain **why** the change was made when the description alone isn't sufficient
- Footers use the `token: value` or `token #value` format (e.g., `Refs: #123`, `Reviewed-by: Name`)
- Footer tokens must use `-` instead of spaces (e.g., `Reviewed-by` not `Reviewed by`); `BREAKING CHANGE` is the sole exception

## Workflow

1. Run `git status` and `git diff --staged` to understand what is being committed
2. If nothing is staged, identify the relevant files and stage them with `git add <file>...` (prefer explicit paths over `git add -A`)
3. Run `git log --oneline -5` to see recent commit style for scope and type consistency
4. Compose the commit message following the format above
5. Commit using a heredoc for multi-line messages:

```bash
git commit -m "$(cat <<'EOF'
type(scope): description

Body text here.

Footer: value
EOF
)"
```
