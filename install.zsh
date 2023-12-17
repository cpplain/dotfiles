#!/bin/zsh

if test $# = 0 || ! (test $1 = "personal" || test $1 = "work"); then
    echo "Usage: install.sh 'personal' | 'work'"
    exit 1
fi

if ! which brew > /dev/null; then
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

ln -sf Brewfile-$1 Brewfile
brew bundle --file Brewfile-$1

echo "Creating symlinks"

REPO_PUB=$(pwd)
REPO_PRV=$REPO_PUB-private

cd ~

mkdir -p .config
mkdir -p Library/Application\ Support/Code/User

ln -sf $REPO_PUB/.config/git .config/
ln -sf $REPO_PRV/.config/git/private .config/git/
ln -sf $REPO_PUB/.config/fish .config/
ln -sf $REPO_PUB/.config/nvim .config/
ln -sf $REPO_PUB/.config/starship.toml .config/
ln -sf $REPO_PUB/.config/wezterm .config/
ln -sf $REPO_PUB/.zshrc ./
ln -sf $REPO_PUB/Library/Application\ Support/Code/User/settings.json Library/Application\ Support/Code/User/
