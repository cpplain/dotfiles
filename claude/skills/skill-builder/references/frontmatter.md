# Frontmatter Reference

Unknown fields are ignored without error in Claude Code. Uploads to claude.ai or the Skills API accept only the spec fields (`name`, `description`, `license`, `compatibility`, `metadata`, `allowed-tools`); any other field is a hard error there, so strip Claude Code fields from skills meant for upload.

## Contents

- Spec fields
- Claude Code fields
- Claude Code vs. spec differences

## Spec fields

| Field           | Required (spec) | Constraints / meaning                                                                                   |
| --------------- | --------------- | ------------------------------------------------------------------------------------------------------- |
| `name`          | Yes             | 1–64 chars, lowercase letters/digits/hyphens, no leading/trailing/consecutive hyphens, matches dir name |
| `description`   | Yes             | 1–1024 chars, non-empty. What it does and when to use it (claude.ai/API also forbid XML tags)            |
| `license`       | No              | License name or path to a bundled license file                                                          |
| `compatibility` | No              | 1–500 chars. Environment requirements (e.g. "Requires gh CLI")                                          |
| `metadata`      | No              | String-to-string map (e.g. `author`, `version`)                                                         |
| `allowed-tools` | No              | Space-separated string; experimental in the spec                                                        |

## Claude Code fields

| Field                      | Values                                     | Meaning                                                                                                   |
| -------------------------- | ------------------------------------------ | --------------------------------------------------------------------------------------------------------- |
| `when_to_use`              | string                                     | Extra trigger context (phrases, example requests). Appended to `description`; counts toward 1,536 cap     |
| `argument-hint`            | string, e.g. `"[issue-number]"`            | Autocomplete hint in the `/` menu                                                                         |
| `arguments`                | space-separated string or YAML list        | Names positional args for `$name` substitution, e.g. `[issue, branch]`                                    |
| `disable-model-invocation` | `true`                                     | Only `/name` runs it; Claude won't auto-invoke                                                            |
| `user-invocable`           | `false`                                    | Hidden from `/` menu and `/name` disabled; only Claude invokes                                            |
| `allowed-tools`            | space/comma-separated or YAML list         | Pre-approved for the invoking turn only. Pattern form: `Bash(git add *) Bash(git commit *)`               |
| `disallowed-tools`         | space/comma-separated or YAML list         | Removed from the tool pool while active; clears on the user's next message                                |
| `model`                    | any `/model` value, or `inherit`           | Model for the rest of the current turn (not saved); with `context: fork`, the subagent's model           |
| `effort`                   | `low` `medium` `high` `xhigh` `max`        | Reasoning effort; available levels depend on the model                                                    |
| `context`                  | `fork`                                     | Run in a forked subagent with no conversation history                                                     |
| `agent`                    | `Explore` `Plan` `general-purpose` or custom | Subagent type for `context: fork` (default `general-purpose`)                                            |
| `background`               | `true` (default) / `false`                 | With `context: fork`: `false` waits for the subagent's result in the invoking turn                        |
| `paths`                    | globs, comma-separated or YAML list        | Limit automatic activation to matching files. Only files inside the cwd match, so sibling worktrees don't  |
| `shell`                    | `bash` (default) / `powershell`            | Shell used for shell injection commands                                                                   |
| `hooks`                    | settings-style hooks object                | Skill-scoped hooks, active from invocation to end of session. See examples.md                             |

## Claude Code vs. spec differences

- `name` is optional in Claude Code (defaults to the directory name) and need not match the directory; a frontmatter `name` sets the `/` command while the directory name still works. The spec requires both. Set and match it anyway.
- `description` is optional in Claude Code (falls back to the first non-empty body line). Always set it.
- Claude Code's 1,536-char limit is a listing truncation, not validation. The spec's 1,024-char limit is the one to design for.
- For portability, write `allowed-tools` as a space-separated string.
