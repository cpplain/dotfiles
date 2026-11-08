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

`create` also links `scripts/link` to `~/.local/bin/dotlink`; the `lna` / `lnc` / `lnp` / `lns` fish abbreviations call that, and `fish/completions/dotlink.fish` completes its commands and `adopt` sources.

```bash
./scripts/link create                           # Create or refresh links
./scripts/link create -n                        # Dry-run
./scripts/link status                           # Show problems (-a also lists ok rows)
./scripts/link adopt git ~/.config/git/config   # → git/config
./scripts/link adopt nvim ~/.config/nvim/lua    # Every file under lua/ → nvim/lua/...
./scripts/link adopt fish ~/.config/fish/functions/*.fish
./scripts/link adopt foo ~/.config/foo          # New source: adds `foo/  ~/.config/foo/` to links
./scripts/link adopt -t ~/ -w work private/bar ~/.barrc
./scripts/link prune                            # Remove leftover symlinks and emptied dirs
./scripts/link prune -n                         # Dry-run prune
```

`adopt <src> <path>...` moves each file into `<src>` and links it back. A directory path adopts every regular file under it; `.DS_Store`, swap files and symlinks are skipped. Paths must live under the source's target and are stored relative to it, not to `~`. If `<src>` is not in `links`, a row is added: its target is the adopted directory, or the files' common parent, unless `-t` is given, and `-w` adds a `when:`. `adopt` checks every file before moving any. It refuses when the destination already exists, when another source already provides the path, or when the row's `when:` does not match this machine, because the link would immediately be a leftover. A directory walk skips the targets of other, more specific sources (`adopt zsh ~/.config` leaves `~/.config/fish/` to `fish/`). More than 20 files asks for confirmation; `-y` skips it.

`create` applies nothing if any target is a regular file or a symlink that does not already point into this repo. `create` does not remove leftovers.

`status` lines: `ok` (only with `-a`), `missing`, `wrong`, `broken`, `nosource` (an explicit row whose source file is gone), `leftover`. Leftover means the symlink still points into the repo but is not in the current plan (deleted source, or `when:` no longer matches). Leftovers are found from the last successful `create` plan plus a scoped scan of planned-target ancestors and their non-home siblings — not a walk of all of `$HOME`. Exit 1 when any planned row is not `ok` or a leftover exists.

`prune` removes leftover symlinks, then any directories that become empty because of it (a lone `.DS_Store` counts as empty; `~` is never removed). Planned `broken` or `wrong` rows are left for `create` / `status`. `create` prints a reminder when leftovers exist.

Optional `when:personal` / `when:work` on a manifest row links that source only when `~/.dotfilesenv` matches. Explicit file rows override the directory walk for the same source, so `claude/settings.personal.json` is not linked as `~/.claude/settings.json` on a work machine.

A leftover Homebrew `lnk` from the previous linker is not removed by `brew bundle`. Use `brew bundle cleanup --global` (`bbc`).

## Documentation

- [Manual Configuration](docs/manual-config.md) - Additional manual setup steps required after installation
