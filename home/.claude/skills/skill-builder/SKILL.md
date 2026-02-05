---
name: skill-builder
description: Create and edit Claude Code skills. Use when users want to create a new skill, update an existing skill, or need guidance on skill structure and best practices.
argument-hint: "[skill-name]"
metadata:
  author: cpplain
  version: "1.0"
---

# Skill Builder

Create skills that extend Claude's capabilities with specialized knowledge, workflows, and tools.

Claude Code skills follow the [Agent Skills open standard](https://agentskills.io/specification), making them compatible with other AI coding tools like OpenAI Codex, GitHub Copilot, Gemini CLI, and Cursor.

## Skill Structure

```
skill-name/
├── SKILL.md           # Required - instructions and frontmatter
├── scripts/           # Optional - executable code
├── references/        # Optional - documentation loaded on demand
└── assets/            # Optional - templates, images, static files
```

**Locations (priority order):**

1. **Enterprise**: Managed settings (organization-wide)
2. **Personal**: `~/.claude/skills/<skill-name>/SKILL.md`
3. **Project**: `.claude/skills/<skill-name>/SKILL.md`
4. **Plugin**: `<plugin>/skills/<skill-name>/SKILL.md` (namespaced as `plugin-name:skill-name`)

Claude auto-discovers skills from subdirectories in monorepos.

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
model: haiku # Optional - model to use (haiku, sonnet, opus)
argument-hint: "[issue-number]" # Optional - shown in autocomplete
hooks: # Optional - skill-scoped hooks
  pre-task: echo "Starting task"
metadata: # Optional - arbitrary key-value pairs
  author: Your Name
  version: 1.0.0
license: MIT # Optional - for distribution
compatibility: Requires gh CLI # Optional - environment requirements
---
Markdown instructions here...
```

### Frontmatter Fields

#### Required Fields

| Field         | Purpose                                                                       |
| ------------- | ----------------------------------------------------------------------------- |
| `name`        | Lowercase, hyphens only (max 64 chars). Must match directory name             |
| `description` | What it does AND when to use it. This is the primary trigger (max 1024 chars) |

#### Claude Code Extensions (Optional)

| Field                      | Purpose                                                                                           |
| -------------------------- | ------------------------------------------------------------------------------------------------- |
| `disable-model-invocation` | `true` = only manual `/skill-name` invocation                                                     |
| `user-invocable`           | `false` = hidden from `/` menu, Claude can still invoke                                           |
| `allowed-tools`            | Tools Claude can use without permission (e.g., `Read, Bash(git *)`)                               |
| `context`                  | `fork` = run in isolated subagent                                                                 |
| `agent`                    | Subagent type when forked: `Explore`, `Plan`, `general-purpose`, or custom from `.claude/agents/` |
| `model`                    | Model to use: `haiku`, `sonnet`, or `opus`                                                        |
| `hooks`                    | Skill-scoped lifecycle hooks                                                                      |
| `argument-hint`            | Autocomplete hint shown in `/` menu (e.g., `[filename]`, `[issue-number]`)                        |

#### Agent Skills Standard (Optional, for cross-platform compatibility)

| Field           | Purpose                                               |
| --------------- | ----------------------------------------------------- |
| `metadata`      | Arbitrary key-value pairs (e.g., `author`, `version`) |
| `license`       | License name or reference to bundled license file     |
| `compatibility` | Environment requirements (max 500 chars)              |

### String Substitutions

| Variable               | Description                   |
| ---------------------- | ----------------------------- |
| `$ARGUMENTS`           | All arguments passed to skill |
| `$0`, `$1`, `$2`       | Individual arguments by index |
| `${CLAUDE_SESSION_ID}` | Current session ID            |

### Dynamic Context Injection

Run shell commands before skill loads with `!&#96;command&#96;`:

```yaml
---
name: pr-review
context: fork
---

PR diff: !&#96;gh pr diff&#96;
Changed files: !&#96;gh pr diff --name-only&#96;

Review this pull request...
```

### Permission Patterns

Control skill access in `.claude/permissions` using these patterns:

- `Skill(skill-name)` - Allow specific skill invocation
- `Skill(skill-name *)` - Allow skill with any arguments
- `Skill(*)` - Allow all skills

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

### 5. Validate

Use the `skills-ref` CLI to validate skill structure:

```bash
skills-ref validate ./my-skill
```

See [github.com/agentskills/agentskills](https://github.com/agentskills/agentskills) for installation.

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

## Best Practices

### Writing Descriptions

- **Third person, not first**: "Processes Excel files" not "I can help you process..."
- **Include trigger keywords**: What it does AND when to use it
- **Be specific**: "Use when working with .xlsx files" helps Claude decide when to invoke

### Naming Conventions

- **Use gerund form**: `processing-pdfs`, `analyzing-data`, `reviewing-code`
- **Lowercase with hyphens**: No underscores, spaces, or capital letters
- **Match directory name**: Required for skill discovery

### Testing and Iteration

- **Test with multiple models**: Haiku needs more explicit guidance than Opus
- **Develop iteratively**: Use one Claude instance to create skills, another to test them
- **Validation loops**: Common pattern is run validator → fix errors → repeat

## Advanced Features

### Extended Thinking Mode

Include the word "ultrathink" in your skill content to enable extended thinking mode for complex reasoning tasks.

### MCP Tool References

Reference MCP tools using fully qualified names: `ServerName:tool_name`

```yaml
Use the database:query_users tool to fetch user information.
```

### Subagent Execution

When `context: fork` is set:

- Skill runs in isolation (no conversation history)
- Skill content becomes the subagent's prompt
- Parent agent sees only summarized results

Built-in agents: `Explore` (read-only), `Plan`, `general-purpose`

### Invocation Control

| Frontmatter                      | User Can Invoke | Claude Can Invoke | Description                               |
| -------------------------------- | --------------- | ----------------- | ----------------------------------------- |
| (default)                        | Yes             | Yes               | Normal behavior                           |
| `disable-model-invocation: true` | Yes             | No                | Manual `/skill-name` only                 |
| `user-invocable: false`          | No              | Yes               | Hidden from `/` menu, Claude auto-invokes |

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

### Task Skill (manual invocation with metadata)

```yaml
---
name: deploy
description: Deploy the application to production
disable-model-invocation: true
context: fork
model: haiku
hooks:
  pre-task: git fetch origin
  post-task: notify-deployment
metadata:
  author: DevOps Team
  version: 2.1.0
  last-updated: 2026-01-15
license: MIT
compatibility: Requires Docker and kubectl CLI
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
