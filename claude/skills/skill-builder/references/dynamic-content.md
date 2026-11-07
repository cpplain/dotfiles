# Dynamic Content

Everything here is processed in a skill's SKILL.md content (and `allowed-tools` Bash rules) when the skill is invoked. The docs don't describe this processing for reference files Claude reads later, which is why these examples live here and not in skill-builder's own SKILL.md. Any skill that *documents* this syntax should do the same.

## Contents

- String substitutions
- Shell injection
- Extended thinking

## String substitutions

| Placeholder                | Expands to                                                          |
| -------------------------- | ------------------------------------------------------------------- |
| `$ARGUMENTS`               | All arguments. If no placeholder uses them, they're appended as `ARGUMENTS: <value>` |
| `$ARGUMENTS[N]`, `$N`      | Argument N, 0-based (`$0` is the first)                             |
| `$name`                    | Named argument declared in the `arguments` frontmatter field        |
| `${CLAUDE_SKILL_DIR}`      | Directory containing SKILL.md (plugin skills: the skill's subdirectory, not the plugin root) — use for bundled scripts |
| `${CLAUDE_PROJECT_DIR}`    | Project root                                                        |
| `${CLAUDE_SESSION_ID}`     | Current session ID                                                  |
| `${CLAUDE_EFFORT}`         | Current effort level                                                |
| `${CLAUDE_PLUGIN_ROOT}`    | Plugin root (plugin skills only)                                    |
| `${CLAUDE_PLUGIN_DATA}`    | Plugin data dir (plugin skills only)                                |

Escape a literal dollar sign before a digit with a backslash: `\$1.00`.

Running a bundled script:

```markdown
Run `python3 ${CLAUDE_SKILL_DIR}/scripts/validate.py <file>` and fix every error it reports.
```

Named arguments:

```yaml
---
name: fix-issue
arguments: [issue, branch]
argument-hint: "<issue> <branch>"
---
Fix GitHub issue $issue on branch $branch.
```

## Shell injection

Runs a command before Claude sees the skill; the output replaces the placeholder and isn't re-scanned for further `!` command placeholders. A failing command aborts the invocation. With bash that is any non-zero exit, except exit 1 from search and comparison commands; append `|| true` to commands expected to exit non-zero.

Inline — recognized only when `!` is at the start of a line or after whitespace:

```markdown
PR diff: !`gh pr diff`
Changed files: !`gh pr diff --name-only`
```

Multi-line — a fenced block whose opening fence is three backticks followed by `!`:

````markdown
```!
git status --short
git log --oneline -5
```
````

- Runs through the Bash tool by default; `shell: powershell` uses the PowerShell tool only when that tool is enabled.
- Injected commands never prompt for permission. If one matches a deny rule, or (outside auto mode) its permission check returns anything other than allow, the invocation aborts with `Shell command permission check failed`. Pre-approve injected commands with `allowed-tools`.
- Users or admins can disable it with `"disableSkillShellExecution": true` in settings; each command is then replaced with `[shell command execution disabled by policy]`. Bundled and managed skills are unaffected. Don't make a skill unusable without it if it may be shared.

## Extended thinking

Including the word `ultrathink` anywhere in a skill's content requests deeper reasoning when the skill runs. Use it only for skills whose task genuinely needs it.
