SHELL := /bin/bash

arch := $(shell uname -m)
brew := /usr/local/bin/brew
ifeq ($(arch), arm64)
brew := /opt/homebrew/bin/brew
endif

dotfiles := $(shell find home -depth 1 | sed 's|home/||')
dotfiles_private := $(shell find private/home -type f | sed 's|private/home/||')

.PHONY: install
install: link install-packages 

.PHONY: install-packages
install-packages: install-brew
	@echo "Installing brew packages"
	eval "$$($(brew) shellenv)" && $(brew) bundle --file home/.Brewfile --force --no-lock

.PHONY: install-brew
install-brew: $(brew)
$(brew):
	@echo "Installing Homebrew"
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

.PHONY: link
link: 
	@echo "Linking dotfiles"
	@for f in $(dotfiles); do ln -svF $(PWD)/home/$$f ~/$$f; done
	@for f in $(dotfiles_private); do ln -svF $(PWD)/private/home/$$f ~/$$f; done

.PHONY: unlink
unlink:
	@echo "Unlinking dotfiles"
	@for f in $(dotfiles_private); do if [ -L ~/$$f ]; then rm -fv ~/$$f; fi; done
	@for f in $(dotfiles); do if [ -L ~/$$f ]; then rm -fv ~/$$f; fi; done
