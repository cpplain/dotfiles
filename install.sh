#!/bin/bash

if test $# = 0 || ! (test $1 = "personal" || test $1 = "work"); then
	echo "Usage: install.sh <personal> | <work>"
	exit 1
fi

if ! which brew >/dev/null; then
	echo "Installing Homebrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	BREW_PREFIX=/opt/homebrew/bin
	if test $(uname -m) = "x86_64"; then
		BREW_PREFIX=/usr/local
	fi
	eval "$($BREW_PREFIX/brew shellenv)"
fi

echo "Installing packages"

brew bundle --file brew-$1/.Brewfile --no-lock

echo "Creating symlinks"

mkdir -p ~/.config
mkdir -p ~/Library/Application\ Support/Code/User

STOW_PKGS=(
	brew-$1
	fish
	git
	git-private
	lazyvim
	nvim
	starship
	vscode
	wezterm
	zsh
)

for PKG in "${STOW_PKGS[@]}"; do
	stow -t $HOME $PKG
done
