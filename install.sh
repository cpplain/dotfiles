#!/bin/bash

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

brew bundle --file brew/.Brewfile --no-lock

echo "Creating symlinks"

mkdir -p ~/.config

STOW_PKGS=(
	brew
	fish
	git
	git-private
	nvim
	starship
	wezterm
	zsh
)

for PKG in "${STOW_PKGS[@]}"; do
	stow -t $HOME $PKG
done
