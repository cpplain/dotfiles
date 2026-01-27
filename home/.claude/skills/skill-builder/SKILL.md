---
name: skill-builder
description: Create and edit Claude Code skills. Use when users want to create a new skill, update an existing skill, or need guidance on skill structure and best practices.
---

# Skill Builder

Create skills that extend Claude's capabilities with specialized knowledge, workflows, and tools.

## Skill Structure

```
skill-name/
├── SKILL.md           # Required - instructions and frontmatter
├── scripts/           # Optional - executable code
├── references/        # Optional - documentation loaded on demand
└── assets/            # Optional - templates, images, static files
```

**Locations:**

- Personal: `~/.claude/skills/<skill-name>/SKILL.md`
- Project: `.claude/skills/<skill-name>/SKILL.md`

## SKILL.md Format

```yaml
---
name: my-skill # Required, lowercase + hyphens, max 64 chars
description: What it does and when # Required, max 1024 chars
disable-model-invocation: true # Optional - manual invocation only
user-invocable: false # Optional - hide from / menu
allowed-tools: Read, Bash(git:*) # Optional - pre-approved tools
context: fork # Optional - run in subagent
agent: Explore # Optional - subagent type when forked
argument-hint: "[issue-number]" # Optional - shown in autocomplete
---
Markdown instructions here...
```

### Frontmatter Fields

| Field                      | Required | Purpose                                                  |
| -------------------------- | -------- | -------------------------------------------------------- |
| `name`                     | Yes      | Lowercase, hyphens only. Must match directory name       |
| `description`              | Yes      | What it does AND when to use it. This triggers the skill |
| `disable-model-invocation` | No       | `true` = only manual `/skill-name` invocation            |
| `user-invocable`           | No       | `false` = hidden from user, Claude can still invoke      |
| `allowed-tools`            | No       | Tools Claude can use without permission                  |
| `context`                  | No       | `fork` = run in isolated subagent                        |
| `agent`                    | No       | Subagent type: `Explore`, `Plan`, etc.                   |
| `argument-hint`            | No       | Autocomplete hint like `[filename]`                      |

### String Substitutions

| Variable               | Description                   |
| ---------------------- | ----------------------------- |
| `$ARGUMENTS`           | All arguments passed to skill |
| `$0`, `$1`, `$2`       | Individual arguments by index |
| `${CLAUDE_SESSION_ID}` | Current session ID            |

### Dynamic Context Injection

Run shell commands before skill loads with `` !`command` ``:

```yaml
---
name: pr-review
context: fork
---

PR diff: !`gh pr diff`
Changed files: !`gh pr diff --name-only`

Review this pull request...
```

## Creation Workflow

### 1. Understand Usage

Ask clarifying questions:

- "What should trigger this skill?"
- "Can you give examples of how it would be used?"
- "What would you say that should activate it?"

### 2. Plan Contents

For each usage example, identify:

- **scripts/**: Code that would be rewritten repeatedly
- **references/**: Documentation Claude should consult
- **assets/**: Templates, images, static files for output

### 3. Write SKILL.md

**Description is critical** - it's the primary trigger mechanism. Include:

- What the skill does
- When to use it (keywords, contexts, file types)

**Keep body under 500 lines.** Move detailed content to `references/`.

**Use imperative form** in instructions.

### 4. Test and Iterate

1. Use the skill on real tasks
2. Notice struggles or inefficiencies
3. Update SKILL.md or resources
4. Repeat

## Design Principles

### Conciseness

Claude is already smart. Only add context Claude doesn't have. Challenge each paragraph: "Does this justify its token cost?"

### Progressive Disclosure

1. **Metadata** (~100 tokens) - always loaded
2. **SKILL.md body** (<5k tokens) - loaded when triggered
3. **References/scripts** - loaded on demand

### Degrees of Freedom

- **High freedom**: Text instructions when multiple approaches are valid
- **Medium freedom**: Pseudocode when a pattern exists but variation is acceptable
- **Low freedom**: Specific scripts when consistency is critical

## Examples

### Reference Skill (background knowledge)

```yaml
---
name: api-conventions
description: API design patterns for this codebase. Use when writing API endpoints.
---
When writing API endpoints:
  - Use RESTful naming
  - Return consistent error formats
  - Include request validation
```

### Task Skill (manual invocation)

```yaml
---
name: deploy
description: Deploy the application to production
disable-model-invocation: true
context: fork
---
1. Run test suite
2. Build application
3. Push to deployment target
```

### Skill with References

```yaml
---
name: database-queries
description: Query the company database. Use when asked about metrics, users, or sales data.
---

## Quick Start

Use the `db` CLI to run queries.

## Schemas

- **Users**: See [references/users.md](references/users.md)
- **Sales**: See [references/sales.md](references/sales.md)
```

## What NOT to Include

- README.md, CHANGELOG.md, or other auxiliary docs
- "When to use this skill" sections in the body (put this in description)
- Explanations Claude already knows
- Deeply nested reference chains
