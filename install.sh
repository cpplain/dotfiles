#!/bin/zsh

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
ln -sf $REPO_PUB/Library/Application\ Support/Code/User/settings.json Library/Application\ Support/Code/User/
ln -sf $REPO_PUB/Library/Application\ Support/iTerm2/DynamicProfiles/profiles.json Library/Application\ Support/iTerm2/DynamicProfiles/
