# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository for managing macOS configuration files using a symlink-based approach. Configuration files remain in the git repository and are symlinked to their expected locations in the home directory.

## Key Commands

### Configuration Management

- `./bin/cfgmanager` - Main management script with options:
  - `--bootstrap` - Full system setup (default)
  - `--create-links` - Create symlinks from repo to home directory
  - `--prune-links` - Remove broken symlinks
  - `--remove-links` - Remove all configuration symlinks
  - `--brew-bundle` - Install/update Homebrew packages
  - `--bundle-cleanup` - Remove packages not in Brewfile

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

### Configuration Approach

The `cfgmanager` script:

1. Sets environment (personal/work) stored in `~/.env`
2. Creates symlinks from `home/*` to `~/*`
3. Manages Homebrew packages declaratively
4. Supports environment-specific configurations via Git conditional includes

### Key Configurations

- **Shell**: Fish with custom prompts and abbreviations
- **Editor**: Neovim with custom configuration
- **Git**: Conditional includes for personal/work accounts
- **Terminal**: Ghostty and WezTerm configurations
- **Languages**: Go, Node.js, Python, Ruby, Rust, Zig

## Pending Tasks

- Add goimports to setup: `go install golang.org/x/tools/cmd/goimports@latest`
