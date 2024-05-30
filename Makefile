SHELL := /bin/bash

arch := $(shell uname -m)
brew := /usr/local/bin/brew
ifeq ($(arch), arm64)
brew := /opt/homebrew/bin/brew
endif

dotfiles := $(shell find home -depth 1 | sed 's|home/||')
dotfiles_private := $(shell find private/home -type f | sed 's|private/home/||')
dotfiles_personal := $(shell find private/personal -type f | sed 's|private/personal/||')
dotfiles_work := $(shell find private/work -type f | sed 's|private/work/||')

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

.PHONY: link-personal
link-personal: link
	@echo "Linking personal dotfiles"
	@for f in $(dotfiles_personal); do ln -sf $(PWD)/private/personal/$$f ~/$$f; done

.PHONY: link-work
link-work: link
	@echo "Linking work dotfiles"
	@for f in $(dotfiles_work); do ln -sf $(PWD)/private/work/$$f ~/$$f; done

.PHONY: link
link: 
	@echo "Linking dotfiles"
	@for f in $(dotfiles); do ln -sf $(PWD)/home/$$f ~/$$f; done
	@for f in $(dotfiles_private); do ln -sf $(PWD)/private/home/$$f ~/$$f; done

.PHONY: unlink
unlink:
	@echo "Unlinking dotfiles"
	@for f in $(dotfiles_work); do if [ -L ~/$$f ]; then rm -f ~/$$f; fi; done
	@for f in $(dotfiles_personal); do if [ -L ~/$$f ]; then rm -f ~/$$f; fi; done
	@for f in $(dotfiles_private); do if [ -L ~/$$f ]; then rm -f ~/$$f; fi; done
	@for f in $(dotfiles); do if [ -L ~/$$f ]; then rm -f ~/$$f; fi; done
