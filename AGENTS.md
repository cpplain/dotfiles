Personal dotfiles. `links` maps each repo path to its target under `~` (some entries only `when:personal` or `when:work`), and `scripts/link` (installed as `dotlink`) creates the symlinks. `private/` is a submodule for sensitive and work-only config.

Edit files here, not at their symlinked targets. `claude/` links into `~/.claude/`, so changes to `claude/CLAUDE.md` or `claude/skills/` affect every project, not just this one.

If you discover something non-obvious about this project, ask if it should be noted in AGENTS.md.
