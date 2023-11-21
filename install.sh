#!/usr/bin/env zsh

REPO_PUB=$(pwd)
REPO_PRV=$(dirname $REPO_PUB)/dotfiles-private

cd ~

mkdir -p .config
mkdir -p Library/Application\ Support/Code/User
mkdir -p Library/Application\ Support/iTerm2/DynamicProfiles

rm .config/git/private
rm .config/git
rm .config/nvim
rm .config/skhd
rm .config/starship.toml
rm .config/wezterm
rm .config/yabai
rm .zshrc
rm Library/Application\ Support/Code/User/settings.json
rm Library/Application\ Support/iTerm2/DynamicProfiles/profiles.json


ln -s $REPO_PUB/.config/git .config/
ln -s $REPO_PRV/.config/git/private .config/git/
ln -s $REPO_PUB/.config/nvim .config/
ln -s $REPO_PUB/.config/skhd .config/
ln -s $REPO_PUB/.config/starship.toml .config/
ln -s $REPO_PUB/.config/wezterm .config/
ln -s $REPO_PUB/.config/yabai .config/
ln -s $REPO_PUB/.zshrc ./
ln -s $REPO_PUB/Library/Application\ Support/Code/User/settings.json Library/Application\ Support/Code/User/
ln -s $REPO_PUB/Library/Application\ Support/iTerm2/DynamicProfiles/profiles.json Library/Application\ Support/iTerm2/DynamicProfiles/
