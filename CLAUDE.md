# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a macOS dotfiles repository using `lnk` (a custom Go-based link manager) for symlink management. Configurations are split between public (`home/`) and private (`private/home/`) directories, both mapping to `~/`.

## Commands

### Link Management (lnk)

```bash
lnk --config home/.config/lnk/config.json create  # Apply all symlinks
lnk status                                         # Show managed files
lnk adopt --path ~/.config/app --source-dir home   # Add file to dotfiles
lnk orphan --path ~/.config/app                    # Remove from management
```

Fish abbreviations: `lnc` (create), `lns` (status), `lna` (adopt), `lno` (orphan)

### Homebrew

```bash
brew bundle --global --verbose --force  # Install from Brewfile
brew bundle dump --global --force       # Export current packages
```

Fish abbreviation: `bb` (update + bundle install)

### Bootstrap (Fresh System)

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/cpplain/dotfiles/main/bootstrap.sh)"
```

## Architecture

### Directory Structure

- `home/` - Public configurations, symlinked to `~/`
- `private/` - Git submodule with private configs, also symlinked to `~/`
- `claude-code/` - Claude Code plugins (LSP server configurations)
- `scripts/` - Utility shell scripts
- `docs/` - Manual configuration steps not yet automated
- `assets/` - Flexoki theme color definitions

### Key Configuration Modules

- `home/.config/fish/` - Fish shell (prompt, abbreviations, functions)
- `home/.config/nvim/` - Neovim with lazy.nvim, LSP, and Treesitter
- `home/.config/git/` - Git config (includes `config_local` and `config_private`)
- `home/.config/ghostty/` - Ghostty terminal
- `home/.config/lnk/` - Link manager configuration
- `home/.claude/` - Claude Code user settings and skills (git-worktree, skill-builder)
- `claude-code/lsp-config/` - Language server definitions (bash, Go, Lua, Ruby, YAML)

### Theme

Flexoki is used across all tools (Neovim, Ghostty). Theme definitions are in `assets/colors/` and implementations in each tool's config. Syntax highlighting convention: magenta=keywords, green=strings, blue=functions, cyan=types, orange=constants, yellow=annotations.

### Private Configs

The `private/` submodule contains sensitive files. Run `git submodule update --init` after cloning. Private configs merge with public ones via git includes and lnk's dual-source mapping.
