-- Bootstrap plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--branch=stable", "--filter=blob:none", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Must remap leader before initializing lazy
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup("plugins", {
	install = { colorscheme = { "catppuccin" } },
	ui = { border = "rounded" },
	change_detection = { notify = false },
	performance = {
		rtp = {
			disabled_plugins = {
				"netrwPlugin",
				"tutor",
			},
		},
	},
})
