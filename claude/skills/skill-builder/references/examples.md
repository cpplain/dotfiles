# Example Skills

## Contents

- Background knowledge (Claude-invoked only)
- Side-effecting task (user-invoked only, forked, with hooks)
- Skill with references and scripts

## Background knowledge

```yaml
---
name: api-conventions
description: API design conventions for this codebase. Use when writing or reviewing HTTP endpoints, request validation, or error responses.
user-invocable: false
paths: "src/api/**"
---

- RESTful resource names, plural nouns
- Errors return `{ "error": { "code", "message" } }`
- Validate request bodies with the shared schema helpers in `src/api/validate.ts`
```

## Side-effecting task

```yaml
---
name: deploy
description: Deploys the application to production. Use only when the user runs /deploy.
disable-model-invocation: true
context: fork
agent: general-purpose
background: false
allowed-tools: Bash(make test) Bash(make build) Bash(./scripts/deploy.sh *)
compatibility: Requires Docker and kubectl
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "${CLAUDE_PROJECT_DIR}/scripts/deploy-guard.sh"
---

1. Run `make test`; stop and report if anything fails.
2. Run `make build`.
3. Run `./scripts/deploy.sh production` and report the deployed version.
```

Skill-scoped hooks use the same structure as hooks in `settings.json`: event name (`PreToolUse`, `PostToolUse`, `Stop`, …) → list of matcher groups → list of handlers. They stay active from invocation until the session ends. Skill substitutions like `${CLAUDE_SKILL_DIR}` are documented only for the markdown body and `allowed-tools` Bash rules, not for hook commands. Hook commands run in the current directory; `${CLAUDE_PROJECT_DIR}` is the documented way to reference project scripts from a hook. Add `once: true` to a handler to remove it after its first successful run (honored only in skill frontmatter).

## Skill with references and scripts

```
database-queries/
├── SKILL.md
├── references/
│   ├── users.md
│   └── sales.md
└── scripts/
    └── run_query.sh
```

```yaml
---
name: database-queries
description: Queries the company analytics database. Use when asked about user, signup, revenue, or sales metrics.
---

## Running queries

Run `${CLAUDE_SKILL_DIR}/scripts/run_query.sh "<sql>"` (execute it; don't read it).

## Schemas

Read only the schema you need:

- Users and signups: [references/users.md](references/users.md)
- Orders and revenue: [references/sales.md](references/sales.md)
```
