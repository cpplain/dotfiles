REPO = $(shell pwd)

.PHONY: dirs links

dirs:
	mkdir -p ~/.config

links: dirs
	# directories
	ln -sfn $(REPO)/fish ~/.config/fish
	ln -sfn $(REPO)/git ~/.config/git
	ln -sfn $(REPO)/nvim ~/.config/nvim
	ln -sfn $(REPO)/private/git ~/.config/git-private
	ln -sfn $(REPO)/wezterm ~/.config/wezterm
	# files
	ln -sf $(REPO)/brew/.Brewfile ~/.Brewfile
	ln -sf $(REPO)/starship/starship.toml ~/.config/starship.toml
	ln -sf $(REPO)/zsh/.zshrc ~/.zshrc
