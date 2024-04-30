SHELL := /bin/bash

arch := $(shell uname -m)
brew := /usr/local/bin/brew
ifeq ($(arch), "arm64")
brew := /opt/homebrew/bin/brew
endif

dotfiles := $(shell find home -type f | sed 's|home|$(HOME)|')
dotfiles_private := $(shell find private/home -type f | sed 's|private/home|$(HOME)|')

.PHONY: install
install: link-dotfiles install-packages 

.PHONY: install-packages
install-packages: install-brew
	@echo "Installing brew packages"
	eval "$$($(brew) shellenv)" && $(brew) bundle --file home/.Brewfile --force --no-lock

.PHONY: install-brew
install-brew: $(brew)

$(brew):
	@echo "Installing Homebrew"
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

.PHONY: link-dotfiles
link-dotfiles: $(dotfiles) $(dotfiles_private) 

$(HOME)/%: $(PWD)/home/%
	mkdir -p $(dir $@)
	ln -sf $< $@

$(HOME)/%: $(PWD)/private/home/%
	mkdir -p $(dir $@)
	ln -sf $< $@

.PHONY: unlink-dotfiles
unlink-dotfiles:
	@echo "Removing dotfile links"
	@for f in $(dotfiles); do if [ -L $$f ]; then rm -fv $$f; fi; done
	@for f in $(dotfiles_private); do if [ -L $$f ]; then rm -fv $$f; fi; done

