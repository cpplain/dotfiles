# Christopher's Dotfiles

<img width="1566" height="1014" alt="Screenshot 2025-09-11 at 2 30 15 PM" src="https://github.com/user-attachments/assets/cc53fd93-723d-4653-b90f-c88ba87a1602" />
<img width="1566" height="1014" alt="Screenshot 2025-09-11 at 2 29 56 PM" src="https://github.com/user-attachments/assets/792aef7b-03f9-4806-9d07-916b78b1ee6c" />

This repo contains my configuration files and related scripts. Feel free to use whatever works for you.

## Base Config

- OS: [macOS](https://support.apple.com/macos)
- Package manager: [Homebrew](https://brew.sh)
- Terminal: [Ghostty](https://ghostty.org/)
- Shell: [fish](https://fishshell.com)
- Editor: [Neovim](https://github.com/neovim/neovim)
- Font: [JetBrains Mono](https://www.jetbrains.com/lp/mono)
- Symbols: [Symbols Nerd Font](https://www.nerdfonts.com)
- Themes: [Flexoki](https://stephango.com/flexoki) (custom themes based on the palette by Steph Ango)

## Installation

```bash
# Fresh system bootstrap (installs Homebrew, lnk, and configures everything)
bash -c "$(curl -fsSL https://raw.githubusercontent.com/cpplain/dotfiles/main/bootstrap.sh)"

# Or if you already have the repo cloned and lnk installed
cd ~/git/dotfiles
lnk --config home/.config/lnk/config.json create
```

## Link Management

This repository uses `lnk`, a Go-based link management tool.

See the [full lnk documentation](https://github.com/cpplain/lnk) for detailed usage.

Quick commands:

```bash
lnk status                                                # Show all managed files
lnk adopt --path ~/.ssh/config --source-dir home          # Add to dotfiles
lnk adopt --path ~/.ssh/config --source-dir private/home  # Add to private repo
lnk orphan --path ~/.config/app                           # Remove from dotfiles
```

## Documentation

- [Manual Configuration](docs/manual-config.md) - Additional manual setup steps required after installation
