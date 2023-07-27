#!/usr/bin/env zsh

if [[ ${PWD##*/} != "tools" ]]; then
    echo "Error: Run 'bootstrap.sh' from the 'tools' directory"
    exit 1
fi

dotfiles_path=$(builtin cd ..; pwd)
dotfiles_private_path=$(builtin cd ../../dotfiles-private; pwd)

echo "Creating symlinks to 'dotfiles' and 'dotfileds-private'"
echo "'dotfiles' path: $dotfiles_path"
echo "'dotfiles-private' path: $dotfiles_private_path"

mkdir -p ~/.config
mkdir -p ~/Library/Application\ Support/Code/User
mkdir -p ~/Library/Application\ Support/iTerm2/DynamicProfiles

# Git
rm ~/.config/git/private
rm ~/.config/git
ln -s $dotfiles_path/git ~/.config/git
ln -s $dotfiles_private_path/git ~/.config/git/private

# iTerm
rm ~/Library/Application\ Support/iTerm2/DynamicProfiles/profiles.json
ln -s $dotfiles_path/iterm/profiles.json ~/Library/Application\ Support/iTerm2/DynamicProfiles/profiles.json

# Neovim
rm ~/.config/nvim
ln -s $dotfiles_path/nvim ~/.config/nvim

# VS Code
rm ~/Library/Application\ Support/Code/User/settings.json
ln -s $dotfiles_path/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

# Zsh
rm ~/.zshrc
ln -s $dotfiles_path/zsh/zshrc ~/.zshrc
