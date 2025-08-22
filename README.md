# Christopher's Dotfiles

![neovim screenshot](./images/screenshot-1.png)

This repo contains my configuration files and related scripts. Feel free to use whatever works for you. You may also find inspiration from [repos that have inspired me](#inspiration).

## Installation

```bash
# Fresh system bootstrap (installs Homebrew, Go, and configures everything)
bash -c "$(curl -fsSL https://raw.githubusercontent.com/cpplain/dotfiles/main/bootstrap.sh)"

# Or if you already have the repo cloned and lnk installed
cd ~/git/dotfiles
lnk --config home/.config/lnk/config.json create
```

## Configuration Management

This repository uses `lnk`, a Go-based link management tool.

See the [full lnk documentation](https://github.com/cpplain/lnk) for detailed usage.

Quick commands:

```bash
lnk status                                                # Show all managed files
lnk adopt --path ~/.ssh/config --source-dir home          # Add to dotfiles
lnk adopt --path ~/.ssh/config --source-dir private/home  # Add to private repo
lnk orphan --path ~/.config/app                           # Remove from dotfiles
```

## Basic Setup

- OS: [macOS](https://support.apple.com/macos)
- Package manager: [Homebrew](https://brew.sh)
- Terminal: [Ghostty](https://ghostty.org/)
- Shell: [fish](https://fishshell.com)
- Editor: [Neovim](https://github.com/neovim/neovim)
- Font: [JetBrains Mono](https://www.jetbrains.com/lp/mono)
- Symbols: [Symbols Nerd Font](https://www.nerdfonts.com)
- Theme: [Flexoki](https://github.com/cpplain/flexoki.nvim)

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
