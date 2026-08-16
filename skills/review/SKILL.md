---
name: review
description: Scoped, single-category code review with convergence constraints. Use when performing targeted code review for specific issue types (security, bugs, dead-code, quality, simplify, tests, or diff-only reviews).
argument-hint: "[security | bugs | dead-code | quality | simplify | tests | diff]"
disable-model-invocation: true
allowed-tools: Read, Glob, Grep, Bash(git:*)
metadata:
  author: cpplain
  version: "1.0"
---

# Scoped Code Review with Convergence Constraints

You are performing a **single-category code review** with hard constraints to ensure convergence. This skill exists because iterative whole-codebase reviews create infinite loops: each pass finds issues, fixes add new code, giving the next review fresh surface area.

## Categories

The user invokes this skill with ONE category argument:

| Category    | Scope                                                                                                       | Key Constraint                                                    |
| ----------- | ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| `security`  | Exploitable vulnerabilities with concrete attack vectors                                                    | No "defense-in-depth" improvements                                |
| `bugs`      | Logic errors causing incorrect behavior now                                                                 | No "could be cleaner" suggestions                                 |
| `dead-code` | Unreachable code, unused imports/vars/functions                                                             | Must verify zero callers via Grep                                 |
| `quality`   | Type errors, resource leaks, broken error recovery                                                          | No style, naming, or refactoring                                  |
| `simplify`  | Overly complex, over-abstracted, or over-engineered code                                                    | Prefer deletion/inlining; net line count must decrease            |
| `tests`     | Test quality and coverage gaps — flaky tests, meaningless assertions, over-mocking, untested critical paths | Improves existing tests; reports gaps but doesn't write new tests |
| `diff`      | Only `+` lines from `git diff HEAD~1`                                                                       | Ignores pre-existing issues entirely                              |

**If no argument provided**: Print this category table and stop. Do not perform a review.

**Category argument**: `${0}`

## Hard Constraints (Apply to ALL Categories)

These constraints are **non-negotiable** and apply to every review:

1. **Maximum 7 issues per review** — Report only the 7 most severe issues. If you find more, defer them.

2. **Fixes modify existing code; they do not create new constructs** — If a fix requires adding new functions, classes, constants, or abstractions that did not exist before, it is NOT a fix for this review. Flag it as "Requires human review: [one-sentence explanation]". You have discretion on fix size, but not on fix shape.

3. **No surrounding refactoring** — Fix ONLY the specific issue. Do not clean up nearby code, rename variables, or improve formatting.

4. **Only broken or vulnerable code** — Do not report "improvable" code. If it works correctly, leave it alone.

5. **Stay in category** — A security review cannot report quality issues. A bugs review cannot report dead code. Strictly enforce category boundaries.

6. **No test changes** unless a test is currently broken. Do not modify tests to "improve coverage" or "make them clearer."

## Explicit Anti-Patterns (DO NOT REPORT)

These are explicitly **not issues** for any category:

- "Extract this into a helper function"
- "Add a constant for this magic number"
- "Add input validation" (unless it's a current vulnerability)
- "Improve this error message"
- "Add type annotations / docstrings"
- "This could be simplified" (unless category is `simplify`)
- "Consider using X instead of Y"
- "Make this more consistent with..."
- "Add logging here"
- "This might be confusing to future developers"

If you find yourself wanting to report any of the above, **stop and reconsider**.

## Category-Specific Review Processes

### `security` Review Process

**Goal**: Find exploitable vulnerabilities with concrete attack vectors.

**Step-by-step**:

1. Identify all external input sources (CLI args, file reads, environment variables, API calls)
2. Trace data flow from external inputs to dangerous operations (command execution, file writes, path construction, eval-like operations)
3. For each potential issue, construct a concrete exploit scenario
4. Report ONLY if the exploit is realistic and achievable

**Do NOT report**:

- "Should validate input" without a concrete exploit
- "Defense-in-depth" improvements
- Theoretical vulnerabilities with no practical attack vector
- Missing input sanitization if the input source is already trusted

**Example valid issue**: "User-controlled `--output` flag is passed directly to `open()` without path validation, allowing directory traversal: `--output ../../etc/passwd` writes to arbitrary paths."

**Example invalid issue**: "Should validate that port is in range 1-65535" (not exploitable if the port comes from config file).

### `bugs` Review Process

**Goal**: Find logic errors causing incorrect behavior under realistic inputs.

**Step-by-step**:

1. Verify return types match expected types
2. Check all code paths reach correct outcomes
3. Verify exception handling doesn't swallow critical errors
4. Check loop termination conditions
5. Verify conditional logic covers all cases

**Do NOT report**:

- "This could be cleaner"
- "Consider refactoring this"
- Edge cases that can't occur in practice
- Style or naming issues
- Performance problems (unless they cause timeouts/hangs)

**Example valid issue**: "Function returns `None` on error but caller expects boolean, causing `TypeError` at line 45."

**Example invalid issue**: "This function is hard to understand" (not a bug).

### `dead-code` Review Process

**Goal**: Find code that is provably unreachable or unused.

**Step-by-step**:

1. Use Glob to find all source files
2. For each candidate (unused import, function, class, variable):
   - Use Grep to search the entire codebase for references
   - Check if it's part of a public API (exported, documented)
   - Check if it's a test utility used by multiple tests
3. Report ONLY if you can prove zero references exist

**Do NOT report**:

- Code that "looks unused" without verification
- Public APIs (even if unused internally)
- Test utilities
- Logging/debugging code
- Code used conditionally (feature flags, platform-specific)

**Example valid issue**: "Function `_legacy_formatter()` has zero callers in codebase (verified via `Grep`). Can be deleted."

**Example invalid issue**: "Function `export_csv()` is not called" (didn't check if it's a public API).

### `quality` Review Process

**Goal**: Find type errors, resource leaks, and broken error recovery.

**Step-by-step**:

1. Check error handling blocks for correct behavior
2. Verify resources (files, connections, locks) are properly released
3. Check type mismatches (string used as int, etc.)
4. Verify exceptions are caught at appropriate levels

**Do NOT report**:

- Style issues
- Naming conventions
- "Could be more Pythonic"
- Missing docstrings or comments
- Performance optimizations

**Example valid issue**: "File handle opened at line 23 is never closed if exception occurs at line 27. Use context manager."

**Example invalid issue**: "Variable name `x` is not descriptive" (style, not quality).

### `simplify` Review Process

**Goal**: Find overly complex, over-abstracted, or over-engineered code. Every fix must result in fewer lines than before.

**Step-by-step**:

1. Find abstractions with only one caller (functions, classes, wrappers)
2. Find constants used exactly once
3. Find defensive validation for impossible cases (e.g., type checking after isinstance)
4. Find wrapper functions that add no value
5. Find overly complex conditional branching
   - Deeply nested if/else (arrow anti-pattern) that can be flattened with early returns/guard clauses
   - Long if/elif chains replaceable with lookup tables or dictionary dispatch
   - Boolean expressions that can be simplified (e.g., `if x == False` → `if not x`, redundant conditions)
6. Find unnecessary intermediate variables
   - Variables assigned once and immediately returned or used on the next line with no added clarity (e.g., `result = foo(); return result` → `return foo()`)
7. For each issue, verify the simplified version has fewer lines

**Do NOT report**:

- Complexity that serves a purpose (multiple callers, legitimate abstraction)
- "Could be simplified" without proving line count reduction
- Abstractions that improve clarity (even if one caller)

**Fix requirement**: The fix must demonstrate NET line reduction. If removing an abstraction requires inlining more code than the abstraction saved, it's not a valid simplification.

**Example valid issue**: "Helper function `_validate_config()` has one caller and just calls two validation functions. Remove it and inline the calls (-5 lines)."

**Example invalid issue**: "Could extract this into a helper" (increases complexity).

### `tests` Review Process

**Goal**: Find test quality issues and coverage gaps. Two distinct parts.

**Part 1: Fix (report as issues with fixes)**
Step-by-step:

1. Find tests that don't assert anything meaningful (only assert function returns, no validation of correctness)
2. Find tests that over-mock dependencies so they don't test real behavior
3. Find tests with timing dependencies (sleeps, brittle timeouts)
4. Find tests that duplicate other tests exactly
5. For each issue, provide a fix that modifies the existing test

**Part 2: Coverage Gaps (report as "Coverage gap:" entries)**
Step-by-step:

1. Identify critical code paths with no test coverage:
   - Error handling branches
   - Security validators
   - Edge cases in parsing/validation
   - Conditional logic branches
2. Report each gap as: "Coverage gap: [description of what's untested]"
3. **DO NOT write the new tests** — just flag what's missing

**Do NOT report**:

- "Should add more tests" without specifics
- Missing tests for trivial getters/setters
- Coverage of internal implementation details
- "Could improve test clarity" (not a test quality issue)

**Example valid issue (Part 1)**: "Test `test_parse_config()` only asserts function doesn't raise exception. Add assertions to verify parsed values are correct."

**Example valid coverage gap (Part 2)**: "Coverage gap: `extract_commands()` error handling when shell command has unbalanced quotes is untested."

**Example invalid issue**: "Add more tests for this module" (too vague).

### `diff` Review Process

**Goal**: Review only the lines changed in the most recent commit.

**Step-by-step**:

1. Run `git diff HEAD~1` to get the diff
2. Extract ONLY lines starting with `+` (additions)
3. Apply all other review constraints to those lines only
4. Ignore all pre-existing code, even if it has issues

**Do NOT report**:

- Issues in unchanged code
- Issues in lines starting with `-` (deletions)
- Context lines (neither `+` nor `-`)

**Example valid issue**: "Line 45 (added in HEAD): variable `result` is unused after assignment."

**Example invalid issue**: "Line 20 has a security issue" (line 20 wasn't changed in HEAD~1).

## Output Format

Use this exact structure for each issue:

```
### Issue N: [Short title]
**Category**: [category] | **File**: [path:line] | **Severity**: CRITICAL|HIGH|MEDIUM

**Problem**: [1-2 sentences explaining what's wrong and why it matters]

**Fix**: [Specific code change OR "Requires human review: [reason]"]
```

### Severity Guidelines

- **CRITICAL**: Security exploits, data loss, crashes
- **HIGH**: Logic errors, resource leaks, broken functionality
- **MEDIUM**: Dead code, quality issues, test gaps

### Summary Line

After all issues, include:

```
---
**Summary**: Found [N] issues in [category] review.
```

If you found more than 7 issues, add:

```
**Note**: [N] additional issues deferred to next pass.
```

## Workflow

1. **Validate category argument** — If `${0}` is empty or invalid, print category table and stop.

2. **Scope the review** — If category is `diff`, run `git diff HEAD~1` first to establish scope.

3. **Find issues** — Follow the category-specific process strictly. Use Glob/Grep/Read as needed.

4. **Apply hard constraints** — Filter to top 7, verify fixes don't create new constructs, eliminate anti-patterns.

5. **Format output** — Use structured format for each issue.

6. **Print summary** — Include issue count and deferrals if applicable.

## Convergence Strategy

This skill is designed to enforce convergence:

- **Capped issue count** prevents infinite work
- **No new constructs** prevents fixes from adding surface area
- **Category isolation** prevents scope creep
- **Anti-patterns list** prevents enhancement inflation
- **Diff mode** enables steady-state reviews of just new changes

After a fix commit, run `/review diff` to verify the fixes didn't introduce new issues. The review should find fewer issues each time, confirming convergence.
