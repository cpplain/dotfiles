SHELL := /bin/bash

arch := $(shell uname -m)
brew := /usr/local/bin/brew
ifeq ($(arch), arm64)
brew := /opt/homebrew/bin/brew
endif

.PHONY: install
install: link install-packages 

.PHONY: install-packages
install-packages: install-brew
	@echo "Installing brew packages"
	eval "$$($(brew) shellenv)" && $(brew) bundle --file home/.Brewfile --force --no-lock

.PHONY: install-brew
install-brew:
	scripts/install-brew.sh

.PHONY: link
link: 
	@scripts/link.sh

.PHONY: unlink
unlink:
	@scripts/unlink.sh
