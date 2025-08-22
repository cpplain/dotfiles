#!/bin/bash
# Bootstrap script for fresh macOS installation
# This script sets up the dotfiles repository and configuration management

set -euo pipefail

echo "Dotfiles Bootstrap"
echo "=================="
echo

# Configuration
DEFAULT_PARENT_DIR="$HOME/git"
LNK_REPO="https://github.com/cpplain/lnk.git"
DOTFILES_REPO="https://github.com/cpplain/dotfiles.git"

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install Homebrew
install_homebrew() {
    if command_exists brew; then
        echo "✓ Homebrew is already installed"
    else
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Add brew to PATH for this session
        if [[ -d "/opt/homebrew" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    fi
}

# Function to install Go
install_go() {
    if command_exists go; then
        echo "✓ Go is already installed"
    else
        echo "Installing Go via Homebrew..."
        brew install go
    fi
}

# Function to install lnk
install_lnk() {
    if command_exists lnk; then
        echo "✓ lnk is already installed"
    else
        echo "Installing lnk..."

        LNK_DIR="$PARENT_DIR/lnk"

        if [[ -d "$LNK_DIR/.git" ]]; then
            echo "lnk repository already exists at $LNK_DIR"
            cd "$LNK_DIR"
            git pull
        else
            # Clone lnk repository
            echo "Cloning lnk repository..."
            mkdir -p "$PARENT_DIR"
            git clone "$LNK_REPO" "$LNK_DIR"
            cd "$LNK_DIR"
        fi

        # Build and install lnk
        echo "Building and installing lnk..."
        make install

        cd "$HOME"
        echo "✓ lnk installed successfully"
    fi
}

# Main bootstrap process
main() {
    echo "This script will:"
    echo "  1. Install Homebrew (if needed)"
    echo "  2. Install Go (if needed)"
    echo "  3. Install lnk (if needed)"
    echo "  4. Clone the dotfiles repository"
    echo "  5. Create configuration symlinks"
    echo "  6. Install Homebrew packages from Brewfile"
    echo

    read -p "Continue? [Y/n] " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]] && [[ ! -z $REPLY ]]; then
        echo "Bootstrap cancelled."
        exit 0
    fi

    # Ask for parent directory for both repos
    echo
    read -p "Where should the git repositories be cloned? [$DEFAULT_PARENT_DIR] " PARENT_DIR
    PARENT_DIR=${PARENT_DIR:-$DEFAULT_PARENT_DIR}
    echo "Repositories will be cloned to:"
    echo "  - $PARENT_DIR/lnk"
    echo "  - $PARENT_DIR/dotfiles"
    echo

    # Step 1: Install Homebrew
    install_homebrew

    # Step 2: Install Go
    install_go

    # Step 3: Install lnk
    install_lnk

    # Step 4: Clone repository
    DOTFILES_DIR="$PARENT_DIR/dotfiles"

    if [[ -d "$DOTFILES_DIR/.git" ]]; then
        echo "✓ Repository already exists at $DOTFILES_DIR"
    else
        echo "Cloning dotfiles repository..."
        mkdir -p "$PARENT_DIR"
        git clone --recurse-submodules "$DOTFILES_REPO" "$DOTFILES_DIR"
    fi

    # Step 5: Create configuration symlinks
    echo
    echo "Creating configuration symlinks..."
    cd "$DOTFILES_DIR"
    lnk --config "$DOTFILES_DIR/home/.config/lnk/config.json" create

    # Step 6: Install Homebrew packages
    echo
    echo "Installing Homebrew packages from Brewfile..."
    brew update && brew bundle --global --verbose --force

    echo
    echo "✓ Bootstrap complete!"
    echo
    echo "Next steps:"
    echo "  1. Restart your terminal or run: source ~/.config/fish/config.fish"
    echo "  2. The 'lnk' command is now available globally"
    echo "  3. Run 'lnk status' to see managed files"
}

# Run main function
main "$@"
