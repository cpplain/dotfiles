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
# Fresh system bootstrap (installs Homebrew and configures everything)
zsh -c "$(curl -fsSL https://raw.githubusercontent.com/cpplain/dotfiles/main/bootstrap.sh)"

# Or if you already have the repo cloned
cd ~/git/dotfiles
./scripts/link create
```

## Link Management

Symlinks are managed by `scripts/link` from the `links` manifest. Each row is `source  target  [when:personal|when:work]`.

A directory source (trailing `/`, or an existing directory) expands to one link per regular file. The path under `source` is appended to `target` (`nvim/init.lua` → `~/.config/nvim/init.lua`). Public and private trees can share a target (`fish/` and `private/fish/` both map to `~/.config/fish/`). An explicit file row maps one file and overrides the walk for that source, even when `when:` skips the row.

`create` also links `scripts/link` to `~/.local/bin/dotlink`; the `lna` / `lnc` / `lnp` / `lns` fish abbreviations call that.

```bash
./scripts/link create                           # Create or refresh links
./scripts/link create -n                        # Dry-run
./scripts/link status                           # Show link status
./scripts/link adopt grok ~/.grok/config.toml   # → grok/config.toml
./scripts/link adopt nvim ~/.config/nvim/init.lua
./scripts/link prune                            # Remove leftover repo-pointing symlinks
./scripts/link prune -n                         # Dry-run prune
```

`adopt` requires `<src>` to already be a directory source in `links`. The file must live under that source's target; it is stored with the path relative to the target, not relative to `~`.

`create` applies nothing if any target is a regular file or a symlink that does not already point into this repo. `create` does not remove leftovers.

`status` lines: `ok`, `missing`, `wrong`, `broken`, `leftover`. Leftover means the symlink still points into the repo but is not in the current plan (deleted source, or `when:` no longer matches). Leftovers are found from the last successful `create` plan plus a scoped scan of planned-target ancestors and their non-home siblings — not a walk of all of `$HOME`. Exit 1 when any planned row is not `ok` or a leftover exists.

`prune` removes leftover symlinks only. Planned `broken` or `wrong` rows are left for `create` / `status`.

Optional `when:personal` / `when:work` on a manifest row links that source only when `~/.dotfilesenv` matches. Explicit file rows override the directory walk for the same source, so `claude/settings.personal.json` is not linked as `~/.claude/settings.json` on a work machine.

A leftover Homebrew `lnk` from the previous linker is not removed by `brew bundle`. Use `brew bundle cleanup --global` (`bbc`).

## Documentation

- [Manual Configuration](docs/manual-config.md) - Additional manual setup steps required after installation
