# Commit Skill Review Checklist

Domain items for skill-builder's review process. Sources: [Conventional Commits v1.0.0](https://www.conventionalcommits.org/en/v1.0.0/) specification (§N) and FAQ.

PASS means SKILL.md states the rule correctly and every example message in it follows the rule.

| ID  | Check | Source |
| --- | ----- | ------ |
| C1  | Header is `<type>[(scope)][!]: <description>`: type noun, optional `!`, then a colon and one space | §1, §5 |
| C2  | `feat` and `fix`, where described, mean a new feature and a bug fix | §2, §3 |
| C3  | Scope is a noun describing a section of the codebase, in parentheses | §4 |
| C4  | Body is optional, begins one blank line after the description, and may span several paragraphs | §6, §7 |
| C5  | Footers begin one blank line after the body; token followed by `: ` or ` #`; tokens use `-` for spaces except `BREAKING CHANGE` | §8, §9 |
| C6  | Breaking changes, on any type, are marked with `!` and/or a `BREAKING CHANGE:` footer; with `!` the footer is optional and the description describes the break | §10–§13 |
| C7  | `BREAKING CHANGE` is uppercase; `BREAKING-CHANGE` is a synonym | §15, §16 |
| C8  | Types other than `feat`/`fix` are presented as permitted by the spec but defined by convention | §14 |
| C9  | `revert` uses a `Refs:` footer with the reverted SHAs | FAQ |
| C10 | A change matching more than one type is split into separate commits where possible | FAQ |
| C11 | Each non-spec rule (case, trailing period, line length, type list) is labelled convention and attributed to a source that actually has it | — |
| C12 | The repo's own convention overrides these defaults, and how to detect it is listed | — |
