#!/usr/bin/env zsh
# Bootstrap script for fresh macOS installation
# This script sets up the dotfiles repository and configuration management

set -euo pipefail

echo "Dotfiles Bootstrap"
echo "=================="
echo

# Configuration
DEFAULT_DOTFILES_ENV="personal"
DEFAULT_DOTFILES_DIR="$HOME/git/dotfiles"
DOTFILES_REPO="https://github.com/cpplain/dotfiles.git"

# Show plan
echo "This script will:"
echo "  1. Set machine role (personal or work)"
echo "  2. Install Homebrew"
echo "  3. Clone the dotfiles repository"
echo "  4. Create configuration symlinks"
echo "  5. Install Homebrew packages from Brewfile"
echo

# Ask for machine role
while true; do
    read "DOTFILES_ENV?Machine role (personal/work)? [$DEFAULT_DOTFILES_ENV] "
    DOTFILES_ENV=${DOTFILES_ENV:-$DEFAULT_DOTFILES_ENV}
    if [[ "$DOTFILES_ENV" == "personal" || "$DOTFILES_ENV" == "work" ]]; then
        break
    fi
    echo "Invalid role. Please enter 'personal' or 'work'."
done
echo

# Ask for dotfiles directory
read "DOTFILES_DIR?Where should dotfiles be cloned? [$DEFAULT_DOTFILES_DIR] "
DOTFILES_DIR=${DOTFILES_DIR:-$DEFAULT_DOTFILES_DIR}
echo

# Confirm
echo "Configuration:"
echo "  Machine role: $DOTFILES_ENV"
echo "  Dotfiles directory: $DOTFILES_DIR"
echo
read -k 1 -r "REPLY?Continue? [Y/n] "
echo
if [[ ! $REPLY =~ ^[Yy]$ ]] && [[ ! -z $REPLY ]]; then
    echo "Bootstrap cancelled."
    exit 0
fi
echo

echo "$DOTFILES_ENV" >"$HOME/.dotfilesenv"

# Install Homebrew
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add brew to PATH for this session
if [[ -d "/opt/homebrew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Clone dotfiles repository
if [[ -d "$DOTFILES_DIR/.git" ]]; then
    echo "✓ Repository already exists at $DOTFILES_DIR"
else
    echo "Cloning dotfiles repository..."
    mkdir -p "$(dirname "$DOTFILES_DIR")"
    git clone --recurse-submodules "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

# Create configuration symlinks
echo
echo "Creating configuration symlinks..."
"$DOTFILES_DIR/scripts/link" create

# Install Homebrew packages
export XDG_CONFIG_HOME="$HOME/.config"

echo
echo "Installing Homebrew packages from Brewfile..."
brew update && brew bundle --global --verbose --force

echo
echo "✓ Bootstrap complete!"
echo
echo "Next steps:"
echo "  1. Restart your terminal or run: source ~/.config/fish/config.fish"
echo "  2. Run 'dotlink status' to see managed files"
echo "  3. Run 'dotlink prune' if status reports leftovers"
