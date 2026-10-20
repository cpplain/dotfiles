---
name: init-lsp
description: >-
  Create a project .grok/lsp.json with only the language servers this repo
  needs. Use when setting up project LSP, initializing per-repo language
  servers, or the user runs /init-lsp.
argument-hint: "[--exclude|--commit] [server...]"
metadata:
  author: cpplain
  version: "1.0"
---

# Init project LSP

Write `<repo>/.grok/lsp.json` with servers this repo actually uses. Copy
entries from the lsp-config plugin. Do not invent command/args/extension maps.

## Catalog

`plugins/lsp-config/.lsp.json` is the only server definition source. List names:

```bash
~/.grok/skills/init-lsp/scripts/init-lsp.sh catalog
```

If that path is missing, resolve the script next to this SKILL.md.

## Detect servers

Use explicit `$ARGUMENTS` server names when the user passed them. Otherwise
detect from the repo root (`git rev-parse --show-toplevel`).

Include a server only when a **primary** marker exists. One README, CI yaml,
or helper script is not enough.

| Server | Primary markers |
| --- | --- |
| `gopls` | `go.mod`, `go.work` |
| `rust-analyzer` | `Cargo.toml` |
| `pyright` | `pyproject.toml`, `setup.py`, `requirements.txt`, `pyrightconfig.json` |
| `typescript-language-server` | `tsconfig.json`, `jsconfig.json`, or `package.json` plus `*.ts`/`*.tsx` |
| `solargraph` | `Gemfile`, `*.gemspec` |
| `lua-language-server` | `.luarc.json`, or this repo is Neovim/Lua config |
| `sourcekit-lsp` | `Package.swift`, `*.xcodeproj`, `*.xcworkspace` |
| `zls` | `build.zig` |
| `bash-language-server` | shell is the main language (`*.sh`/`*.bash`/`*.zsh` dominate) |
| `css-language-server` | first-class `*.css`/`*.scss`/`*.less` (a frontend, not one file) |
| `html-language-server` | first-class `*.html` templates or pages |
| `taplo` | TOML is a product surface, not only `Cargo.toml`/`pyproject.toml` |
| `yaml-language-server` | YAML is a product surface (k8s, ansible), not only `.github/` |
| `marksman` | Markdown is the product (docs site, wiki), not only `README.md` |

Skip a server whose `command` is not on `PATH`. Warn. Still write the others.

If detection finds nothing and the user named no servers, list the catalog and
stop.

## Exclude vs commit

`.git/info/exclude` is local and shared across worktrees.

- User said exclude / ignore / local-only → exclude
- User said commit / share / track → do not exclude
- Path already ignored (`git check-ignore -q .grok/lsp.json`) → skip
- Path already tracked → do not exclude unless the user asked
- Otherwise ask: **Exclude locally** (work repos) or **Leave commitable** (repos you own)

## Write

Existing `.grok/lsp.json` (follow a symlink): replace with the detected set
unless the user said "add X", in which case merge.

Exclude → write the main clone, then link this tree:

```bash
main=$(dirname "$(git rev-parse --path-format=absolute --git-common-dir)")
~/.grok/skills/init-lsp/scripts/init-lsp.sh write --dest "$main/.grok/lsp.json" <servers...>
~/.grok/skills/init-lsp/scripts/init-lsp.sh exclude
[ -x ~/.grok/hooks/link-ignored-lsp.sh ] && ~/.grok/hooks/link-ignored-lsp.sh
```

Commitable → write this worktree root:

```bash
~/.grok/skills/init-lsp/scripts/init-lsp.sh write --dest "$(git rev-parse --show-toplevel)/.grok/lsp.json" <servers...>
```

The script copies catalog entries verbatim and rejects unknown names.

## Plugin accuracy

After writing, check each selected `command` against `--help`. If args or
extensions are wrong, patch `plugins/lsp-config/.lsp.json` when that file is
in this workspace, then rewrite the project file. Do not fork definitions
into the project file.

## Report

List servers written, dest path, exclude yes/no, and any missing binaries or
plugin patches.
