# Christopher's Dotfiles

![neovim screenshot](./images/screenshot-1.png)

This repo contains my configuration files (aka dotfiles) and related scripts. Feel free to use whatever works for you. You may also find inspiration from [repos that have inspired me](#inspiration).

## Installation

```bash
# Fresh system bootstrap (installs Homebrew, Go, and configures everything)
bash -c "$(curl -fsSL https://raw.githubusercontent.com/cpplain/dotfiles/main/bin/bootstrap)"

# Or if you already have the repo cloned and cfgman installed
cd ~/git/dotfiles
cfgman create-links
```

## Configuration Management

This repository uses `cfgman`, a Go-based dotfile management tool with the following features:

- **Fast execution** - Written in Go for improved performance over shell scripts
- **File-level and directory-level linking** - Links individual files by default, directories when specified
- **Adopt/orphan files** - Easily add or remove files from version control
- **Dual repositories** - Separate public and private configuration repos
- **Git integration** - Automatically respects `.gitignore` patterns
- **Zero dependencies** - Pure Go implementation using only the standard library

See the [full cfgman documentation](go/README.md) for detailed usage.

Quick commands:

```bash
cfgman status                        # Show all managed files
cfgman adopt ~/.config/app           # Add file to dotfiles
cfgman adopt --private ~/.ssh/config # Add to private repo
cfgman orphan ~/.config/app          # Remove from dotfiles
cfgman orphan --dry-run ~/.config    # Preview recursive removal
```

## Basic Setup

- OS: [macOS](https://support.apple.com/macos)
- Package manager: [Homebrew](https://brew.sh)
- Terminal: [Ghostty](https://ghostty.org/)
- Shell: [fish](https://fishshell.com)
- Editor: [Neovim](https://github.com/neovim/neovim) ([LazyVim](https://www.lazyvim.org/))
- Font: [SF Mono](https://developer.apple.com/fonts/)
- Symbols: [Symbols Nerd Font](https://www.nerdfonts.com)
- Theme: [Catppuccin](https://github.com/wez/wezterm)

## Documentation

- [Manual Configuration](docs/manual-config.md) - Additional manual setup steps required after installation

## Inspiration

- [branchvincent / dotfiles](https://github.com/branchvincent/dotfiles)
- [cgsdev0 / dotfiles](https://github.com/cgsdev0/dotfiles)
- [craftzdog / dotfiles-public](https://github.com/craftzdog/dotfiles-public)
- [fatih / dotfiles](https://github.com/fatih/dotfiles)
- [GeekMasher / .dotfiles](https://github.com/GeekMasher/.dotfiles)
- [LazyVim / LazyVim](https://github.com/LazyVim/LazyVim)
- [nvim-lua / kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- [stevearc / dotfiles](https://github.com/stevearc/dotfiles)
- [ThePrimeagen / neovimrc](https://github.com/ThePrimeagen/neovimrc)
- [tjdevries / config_manager](https://github.com/tjdevries/config_manager)
