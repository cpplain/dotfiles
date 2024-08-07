#!/usr/bin/env bash

set -e

[ -f ~/.env ] && source ~/.env

set_env() {
    while true; do
        echo "Confgure environement for:"
        echo "[1] personal (default)"
        echo "[2] work"
        read -p "Enter selection: " ENV
        case $ENV in
        2)
            ENV=work
            ;;
        *)
            ENV=personal
            ;;
        esac

        read -p "Target repo directory: " REPO_DIR
        REPO_DIR="${REPO_DIR/#\~/$HOME}"

        echo "Configuration environment: $ENV"
        echo "Dotfiles repo: $REPO_DIR"
        read -p "Continue? [Y/n]: " YN
        case $YN in
        n)
            continue
            ;;
        *)
            break
            ;;
        esac
    done

    echo "CONFIG_ENV=$ENV" >~/.env
    echo "DOTFILES_REPO_DIR=$REPO_DIR" >>~/.env
}

install_brew() {
    echo "Installing brew"
    case $(uname -sm) in
    "Darwin arm64")
        brew=/opt/homebrew/bin/brew
        ;;
    *)
        brew=/usr/local/bin/brew
        ;;
    esac
    test -x $brew && echo "Brew already installed: $brew" && return
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
}

clone_repo() {
    echo "Cloning dotfiles repo"
    test -d $DOTFILES_REPO_DIR/.git && echo "Repo already exists: $DOTFILES_REPO_DIR" && return
    git clone --recurse-submodules https://github.com/cpplain/dotfiles.git $DOTFILES_REPO_DIR
}

bootstrap() {
    set_env
    source ~/.env
    install_brew
    clone_repo
    source $DOTFILES_REPO_DIR/scripts/links.sh
    create_links
    source $DOTFILES_REPO_DIR/scripts/brew.sh
    brew_bundle
}

usage() {
    cat <<EOS
Usage: cfgmanager.sh [options]
    --brew-bundle   Update brew, install packages, upgrade packages
    --create-links  Create links to cofiguration files
    --prune-links   Prune broken links
    --remove-links  Remove all links to configuration files
    --bootstrap     Bootstrap configuration (default)
    -h, --help      Display this message
EOS
}

case $1 in
--brew-bundle)
    source $DOTFILES_REPO_DIR/scripts/brew.sh
    brew_bundle
    ;;
--create-links)
    source $DOTFILES_REPO_DIR/scripts/links.sh
    create_links
    ;;
--prune-links)
    source $DOTFILES_REPO_DIR/scripts/links.sh
    prune_links
    ;;
--remove-links)
    source $DOTFILES_REPO_DIR/scripts/links.sh
    remove_links
    ;;
-h | --help)
    usage
    ;;
* | --bootstrap)
    bootstrap
    ;;
esac
