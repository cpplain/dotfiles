SHELL := /bin/bash

arch := $(shell uname -m)
brew := /usr/local/bin/brew
ifeq ($(arch), arm64)
brew := /opt/homebrew/bin/brew
endif

privatedir := $(PWD)/private

dotfiles := $(shell find home -depth 1 | sed 's|home/||')
dotfiles_private := $(shell cd $(privatedir) && find home_private -type f | sed 's|home_private/||')
dotfiles_personal := $(shell cd $(privatedir) &&  find home_personal -type f | sed 's|home_personal/||')
dotfiles_work := $(shell cd $(privatedir) &&  find home_work -type f | sed 's|home_work/||')

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
	@scripts/link.sh

.PHONY: unlink
unlink:
	@echo "Unlinking dotfiles"
	@for f in $(dotfiles_work); do if [ -L ~/$$f ]; then rm -f ~/$$f; fi; done
	@for f in $(dotfiles_personal); do if [ -L ~/$$f ]; then rm -f ~/$$f; fi; done
	@for f in $(dotfiles_private); do if [ -L ~/$$f ]; then rm -f ~/$$f; fi; done
	@for f in $(dotfiles); do if [ -L ~/$$f ]; then rm -f ~/$$f; fi; done
