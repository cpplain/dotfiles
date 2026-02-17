#!/bin/bash
# Bootstrap script for fresh macOS installation
# This script sets up the dotfiles repository and configuration management

set -euo pipefail

echo "Dotfiles Bootstrap"
echo "=================="
echo

# Configuration
DEFAULT_DOTFILES_DIR="$HOME/git/dotfiles"
DOTFILES_REPO="https://github.com/cpplain/dotfiles.git"

# Show plan and get confirmation
echo "This script will:"
echo "  1. Install Homebrew"
echo "  2. Install lnk via Homebrew"
echo "  3. Clone the dotfiles repository"
echo "  4. Create configuration symlinks"
echo "  5. Install Homebrew packages from Brewfile"
echo

read -p "Continue? [Y/n] " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]] && [[ ! -z $REPLY ]]; then
    echo "Bootstrap cancelled."
    exit 0
fi

# Ask for dotfiles directory
echo
read -p "Where should dotfiles be cloned? [$DEFAULT_DOTFILES_DIR] " DOTFILES_DIR
DOTFILES_DIR=${DOTFILES_DIR:-$DEFAULT_DOTFILES_DIR}
echo "Dotfiles will be cloned to: $DOTFILES_DIR"
echo

# Step 1: Install Homebrew
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add brew to PATH for this session
if [[ -d "/opt/homebrew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Step 2: Install lnk
echo "Installing lnk..."
brew install cpplain/tap/lnk

# Step 3: Clone dotfiles repository
if [[ -d "$DOTFILES_DIR/.git" ]]; then
    echo "✓ Repository already exists at $DOTFILES_DIR"
else
    echo "Cloning dotfiles repository..."
    mkdir -p "$(dirname "$DOTFILES_DIR")"
    git clone --recurse-submodules "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

# Step 4: Create configuration symlinks
echo
echo "Creating configuration symlinks..."
cd "$DOTFILES_DIR"
lnk --config "$DOTFILES_DIR/home/.config/lnk/config.json" create

# Step 5: Install Homebrew packages
echo
echo "Installing Homebrew packages from Brewfile..."
brew update && brew bundle --global --verbose --force

echo
echo "✓ Bootstrap complete!"
echo
echo "Next steps:"
echo "  1. Restart your terminal or run: source ~/.config/fish/config.fish"
echo "  2. Run 'lnk status' to see managed files"
