#!/bin/bash

if test $# = 0 || ! (test $1 = "personal" || test $1 = "work"); then
	echo "Usage: install.sh <personal> | <work>"
	exit 1
fi

if ! which brew >/dev/null; then
	echo "Installing Homebrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	if test $(uname -m) = "arm64"; then
		eval "$(/opt/homebrew/bin/brew shellenv)"
	fi

	if test $(uname -m) = "x86_64"; then
		eval "$(/usr/local/brew shellenv)"
	fi
fi

echo "Installing packages"

brew bundle --file brew-$1/.Brewfile --no-lock

echo "Creating symlinks"

mkdir -p ~/.config
mkdir -p ~/Library/Application\ Support/Code/User

ln -sF $(pwd)/brew-$1/.Brewfile ~/
ln -sF $(pwd)/fish/.config/fish ~/.config
ln -sF $(pwd)/git/.config/git ~/.config
ln -sF $(pwd)/lazyvim/.config/lazyvim ~/.config
ln -sF $(pwd)/nvim/.config/nvim ~/.config
ln -sF $(pwd)/starship/.config/starship.toml ~/.config
ln -sF $(pwd)/vscode/Library/Application\ Support/Code/User/settings.json ~/Library/Application\ Support/Code/User
ln -sF $(pwd)/wezterm/.config/wezterm ~/.config
ln -sF $(pwd)/zsh/.zshrc ~/
