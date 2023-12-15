#!/bin/zsh

if ! which brew > /dev/null; then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if which /usr/local/bin/brew > /dev/null; then
    eval "$(/usr/local/brew shellenv)"
  fi

  if which /opt/homebrew/bin/brew > /dev/null; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

echo "Installing packages"

brew update
brew bundle

echo "Creating symlinks"

REPO_PUB=$(pwd)
REPO_PRV=$REPO_PUB-private

cd ~

mkdir -p .config
mkdir -p Library/Application\ Support/Code/User
mkdir -p Library/Application\ Support/iTerm2/DynamicProfiles

ln -sf $REPO_PUB/.config/git .config/
ln -sf $REPO_PRV/.config/git/private .config/git/
ln -sf $REPO_PUB/.config/fish .config/
ln -sf $REPO_PUB/.config/nvim .config/
ln -sf $REPO_PUB/.config/skhd .config/
ln -sf $REPO_PUB/.config/starship.toml .config/
ln -sf $REPO_PUB/.config/wezterm .config/
ln -sf $REPO_PUB/.config/yabai .config/
ln -sf $REPO_PUB/.zshrc ./
ln -sf $REPO_PUB/Brewfile ./
ln -sf $REPO_PUB/Library/Application\ Support/Code/User/settings.json Library/Application\ Support/Code/User/
ln -sf $REPO_PUB/Library/Application\ Support/iTerm2/DynamicProfiles/profiles.json Library/Application\ Support/iTerm2/DynamicProfiles/
