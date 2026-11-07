---
name: skill-builder
description: Claude Code-specific reference for writing and editing skills — frontmatter fields, invocation control, forked subagents, arguments, shell injection, skill-scoped hooks, permissions, and validation. Use when creating or updating a SKILL.md, choosing frontmatter, or debugging why a skill doesn't trigger or behaves unexpectedly.
argument-hint: "[skill-name]"
metadata:
  author: cpplain
  version: "2.0"
---

# Skill Builder

Target skill (may be empty): $ARGUMENTS

This skill covers what is specific to Claude Code. For the full create → test → iterate workflow (test cases, baseline runs without the skill, description tuning), use the `skill-creator` skill if it is available and use this one alongside it for Claude Code details.

## Reference files

Read these before writing the parts they cover. They are kept out of this file on purpose: SKILL.md content is preprocessed (argument substitution, shell injection), so literal examples here would be executed or rewritten when this skill loads.

- [references/frontmatter.md](references/frontmatter.md) — every field, its values, and Claude Code vs. Agent Skills spec constraints
- [references/dynamic-content.md](references/dynamic-content.md) — argument and path substitutions, shell injection, extended-thinking keyword
- [references/examples.md](references/examples.md) — complete example skills, including skill-scoped hooks

## Structure and locations

```
skill-name/
├── SKILL.md       # Required: frontmatter + instructions
├── scripts/       # Executed, not loaded into context
├── references/    # Loaded on demand via relative links from SKILL.md
└── assets/        # Static resources: templates, images, data files
```

| Scope      | Path                                     | Notes                                |
| ---------- | ---------------------------------------- | ------------------------------------ |
| Enterprise | managed settings dir `.claude/skills/`   | Highest precedence                   |
| Personal   | `~/.claude/skills/<name>/SKILL.md`       | Overrides project                    |
| Project    | `.claude/skills/<name>/SKILL.md`         |                                      |
| Plugin     | `<plugin>/skills/<name>/SKILL.md`        | Namespaced as `/plugin-name:name`    |

- Project skills apply to sessions in the repository. A subdirectory's `.claude/skills/` applies to sessions started in or below it; a session started above it loads the skill the first time Claude works on files there.
- Adding, editing, or removing a SKILL.md in a watched skills directory is picked up live. A top-level skills directory created mid-session isn't watched: run `/reload-skills` after creating it and after each later change there.
- `.claude/commands/<name>.md` still works and is merged with skills; a skill with the same name wins. Prefer skills for new work.
- This user's personal skills are sourced from `~/git/dotfiles/claude/skills/`; edit them there, not in `~/.claude/skills/`. `dotlink` symlinks each file (not the directory) into `~/.claude/skills/`. After adding files to a skill, run `dotlink create` or they won't be visible.

## Frontmatter essentials

Both `name` (defaults to the directory name) and `description` (defaults to the first non-empty body line) are optional in Claude Code, but always set `description`. For portability to other Agent Skills tools, always set `name` and make it match the directory. Full field list: [references/frontmatter.md](references/frontmatter.md).

**Invocation control:**

| Frontmatter                      | `/name` works | Claude auto-invokes | Use for                                   |
| -------------------------------- | ------------- | ------------------- | ----------------------------------------- |
| (default)                        | Yes           | Yes                 | Most skills                               |
| `disable-model-invocation: true` | Yes           | No                  | Side effects: deploys, commits, messages  |
| `user-invocable: false`          | No            | Yes                 | Background knowledge, not a command       |

**Forked execution:** `context: fork` runs the skill body as the prompt of a subagent with no conversation history; the caller sees only its result. Pick the subagent with `agent` (`Explore`, `Plan`, `general-purpose`, or a custom agent from `.claude/agents/`). `background: false` makes the caller wait for the result in the same turn.

**Tool access:** `allowed-tools` pre-approves tools for the invoking turn only; `disallowed-tools` removes tools while the skill is active. Use the `Bash(git commit *)` pattern form.

**Hooks:** skill-scoped `hooks` stay registered for the rest of the session once the skill is invoked, not just while it runs. Skill-directory substitution isn't documented for hook commands; reference scripts by project-dir variable or absolute path. See [references/examples.md](references/examples.md).

## Writing the description

The skill's name and description (plus optional `when_to_use`) in the skill listing are all Claude sees before deciding to load the skill.

- State what the skill does **and** when to use it: trigger phrases, file types, contexts.
- Write in third person ("Processes Excel files", not "I can help…").
- Be specific and include key terms; avoid vague descriptions like "Helps with documents".
- Claude Code truncates `description` + `when_to_use` at 1,536 characters in the listing, and when the listing exceeds its budget (1% of the context window) it drops some descriptions, least-invoked skills first. The spec caps `description` at 1,024 characters — stay under that.
- Put trigger guidance in the description, not a "When to use" section in the body (the body isn't loaded until after the decision).

## Writing the body

- **Concise.** Claude already knows general concepts; include only what it doesn't. Keep SKILL.md under 500 lines; the spec also recommends a body under 5,000 tokens.
- **One level of references.** Link every reference file directly from SKILL.md; don't chain references to references. Add a table of contents to any reference file over 100 lines.
- **Match freedom to fragility.** Prose when many approaches work; pseudocode when a pattern matters; an exact script when consistency is critical.
- **Say whether to run or read** each script, and reference scripts via the skill-directory substitution (see [references/dynamic-content.md](references/dynamic-content.md)) so paths work from any cwd.
- **Checklists and feedback loops** for multi-step work: validate → fix → repeat; plan → validate → execute for batch or destructive changes.
- **One default approach**, not a menu of options. Consistent terminology throughout.
- **No time-sensitive content** (dates, "currently", version-specific notes) unless in an "Old patterns" section.
- **Forward slashes** in all paths. Descriptive file names.
- **MCP tools** are named `mcp__<server>__<tool>` in Claude Code (plugin servers: `mcp__plugin_<plugin>_<server>__<tool>`).
- **Front-load what matters.** After auto-compaction Claude Code re-attaches only the first 5,000 tokens of each invoked skill, within a 25,000-token shared budget filled from the most recently invoked skill (older skills can be dropped entirely). Re-invoke to restore it, so put the core instructions first.

## Naming

- Lowercase letters, digits, hyphens; max 64 chars; no leading, trailing, or doubled hyphens.
- For claude.ai or API upload: must not contain `anthropic` or `claude`, or XML tags. Claude Code itself reserves only `anthropic-skills`.
- Gerund form (`processing-pdfs`) is suggested; noun phrases are fine. Avoid vague names like `helper`, `utils`, `tools`, `data`.

## Permissions

Control whether Claude may invoke skills with permission rules in `settings.json` (`permissions.allow` / `permissions.deny`) or via `/permissions`:

- `Skill(name)` — exact skill
- `Skill(name *)` — skill with any arguments
- `Skill` in deny — disable the Skill tool entirely

The `disableSkillShellExecution` setting disables shell injection for user, project, plugin, and added-directory skills (bundled and managed skills are unaffected).

## Validate and test

1. `claude plugin validate <skills-dir>` — finds SKILL.md files whose frontmatter doesn't parse. Pass the skills directory, not a single skill.
2. `skills-ref validate ./skill-name` — Agent Skills spec conformance (from github.com/agentskills/agentskills).
3. Behavior: write a few realistic test prompts first, run them with and without the skill, and compare. `skill-creator` drives this loop inside a conversation. For a skill shipped in a plugin, `claude plugin eval` runs a similar comparison in its own format (not interchangeable with skill-creator's) and can gate CI.
4. Test with the models that will run the skill — smaller models need more explicit guidance.
5. `/skill-doctor` shows each skill's context cost and usage; use it to find skills whose descriptions are too long or never trigger.
