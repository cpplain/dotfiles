REPO = $(shell pwd)

.PHONY: dirs links

dirs:
	mkdir -p ~/.config

links:
	ln -sf $(REPO)/brew/.Brewfile ~/
	ln -sf $(REPO)/fish ~/.config/
	ln -sf $(REPO)/git ~/.config/
	# ln -sf $(REPO)/private/git-private ~/.config/
	ln -sf $(REPO)/nvim ~/.config/
	ln -sf $(REPO)/starship/starship.toml ~/.config/
	ln -sf $(REPO)/wezterm ~/.config/
	ln -sf $(REPO)/zsh/.zshrc ~/
