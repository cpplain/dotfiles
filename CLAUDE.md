# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository for managing macOS configuration files using a symlink-based approach. Configuration files remain in the git repository and are symlinked to their expected locations in the home directory.

## Key Commands

### Configuration Management

- `cfgman` - Main management tool (external Go binary from https://github.com/cpplain/cfgman) with commands:
  - `cfgman init` - Initialize cfgman configuration
  - `cfgman create-links [--dry-run]` - Create symlinks from repo to home directory
  - `cfgman status` - Show all managed symlinks and their status
  - `cfgman adopt <path> [source_dir] [--dry-run]` - Move file/directory into repo and create symlink
  - `cfgman orphan <path> [--dry-run]` - Remove from repo management (recursive for directories)
  - `cfgman remove-links [--dry-run]` - Remove all configuration symlinks
  - `cfgman prune-links [--dry-run]` - Remove broken symlinks
  - `cfgman help [command]` - Show help for a specific command

### Development Commands

- Fish shell is the default shell
- Neovim configuration is a custom config (home/.config/nvim)
- LazyVim configuration available for testing purposes
- Terminal: Ghostty (primary), WezTerm (secondary)

## Architecture

### Directory Structure

- `home/` - Public configuration files to be symlinked
- `private/` - Git submodule containing private repository for work and sensitive configurations
- `bin/` - Scripts available in PATH
- `scripts/` - Utility scripts

### Configuration Files

The `.linkconfig.json` file uses the following format:

```json
{
  "link_mappings": [
    {
      "source": "home",
      "target": "~/",
      "link_as_directory": [".config/nvim", ".ssh"]
    },
    {
      "source": "private/home",
      "target": "~/",
      "link_as_directory": []
    }
  ]
}
```

- `source`: Directory in your repo containing configs
- `target`: Where symlinks are created (usually `~/`)
- `link_as_directory`: Directories to link as complete units instead of individual files

### Configuration Approach

The `cfgman` tool is an external Go binary (https://github.com/cpplain/cfgman) that:

1. Manages configuration via `~/.config/cfgman/config.json`
2. Creates symlinks based on `.linkconfig.json` mappings
3. Supports file-level and directory-level linking
4. Allows bidirectional file management (adopt existing files, orphan managed files)
5. Respects `.gitignore` patterns automatically when git is available
6. Supports both public and private configuration repositories
7. Uses JSON configuration format (`.linkconfig.json`)
8. Provides fast execution as a compiled Go binary

### Key Configurations

- **Shell**: Fish with custom prompts and abbreviations
- **Editor**: Neovim with custom configuration
- **Git**: Conditional includes for personal/work accounts
- **Terminal**: Ghostty and WezTerm configurations
- **Languages**: Go, Node.js, Python, Ruby, Rust, Zig

## Pending Tasks

- Add goimports to setup: `go install golang.org/x/tools/cmd/goimports@latest`
