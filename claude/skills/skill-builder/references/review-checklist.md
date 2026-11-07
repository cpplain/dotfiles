# Skill Review Checklist

## Contents

- Process rules
- Frontmatter
- Body
- Dynamic content
- Accuracy
- Validation

## Process rules

1. Evaluate every item below, plus every item in the reviewed skill's own `references/review-checklist.md` if it has one. Output one table row per item: ID | PASS / FAIL / N/A | evidence (`file:line`).
2. Every FAIL includes the exact edit that fixes it. No open questions, no "consider".
3. Concerns not covered by an item are not findings. List them under "Proposed checklist additions"; the user accepts one (it becomes an item) or rejects it (never raise it again).
4. Re-review after fixes checks only the FAILed items and items covering lines the fix edited. No new full pass.
5. Done = every item is PASS or N/A.

A skill's `references/review-checklist.md` is for reviews only: it is exempt from B2 and must not be linked from that skill's SKILL.md.

## Frontmatter

| ID | Check | Source |
| -- | ----- | ------ |
| F1 | `name` is set, matches the directory, and follows the naming rules | SKILL.md: Naming |
| F2 | `description` is set, ≤1,024 chars, third person, and states what the skill does and when to use it | SKILL.md: Writing the description |
| F3 | Every task the description promises is covered in the body | SKILL.md: Writing the description |
| F4 | Only fields in frontmatter.md are used; `allowed-tools` is a space-separated string in pattern form | frontmatter.md |
| F5 | A side-effecting skill has `disable-model-invocation: true` or a description that triggers only on an explicit user request | SKILL.md: Invocation control |

## Body

| ID | Check | Source |
| -- | ----- | ------ |
| B1 | Body is under 500 lines, has no "When to use" section, and puts core instructions first | SKILL.md: Writing the body |
| B2 | References are one level deep and linked from SKILL.md; any reference over 100 lines has a table of contents | SKILL.md: Writing the body |
| B3 | Scripts are referenced via the skill-directory substitution, and each says whether to run or read it | SKILL.md: Writing the body |
| B4 | No time-sensitive content; one default approach per step | SKILL.md: Writing the body |

## Dynamic content

| ID | Check | Source |
| -- | ----- | ------ |
| D1 | No literal example in SKILL.md is unintentionally substituted (argument placeholders) or executed (shell injection) | dynamic-content.md |
| D2 | Every injected command, and each part of a compound one, is allowed by `allowed-tools` and cannot exit non-zero in normal states | dynamic-content.md: Shell injection |
| D3 | The skill still works with `disableSkillShellExecution`: a fallback for injected content is stated | dynamic-content.md: Shell injection |

## Accuracy

| ID | Check | Source |
| -- | ----- | ------ |
| A1 | Every claim attributed to an external source (spec, tool docs) matches that source | — |

## Validation

| ID | Check | Source |
| -- | ----- | ------ |
| V1 | `claude plugin validate <skills-dir>` passes | SKILL.md: Validate and test |
| V2 | One real invocation in a realistic state loads without error | SKILL.md: Validate and test |
