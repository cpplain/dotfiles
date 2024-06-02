SHELL := /bin/bash

.PHONY: install
install: link install-packages 

.PHONY: install-packages
install-packages: install-brew
	scripts/install-packages.sh

.PHONY: install-brew
install-brew:
	scripts/install-brew.sh

.PHONY: link
link: 
	@scripts/link.sh

.PHONY: unlink
unlink:
	@scripts/unlink.sh
