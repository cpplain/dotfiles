-- Bootstrap Plugin Manager and Config

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Must be set before initializing lazy
vim.g.mapleader = " " -- Set <Space> as <Leader>
vim.g.maplocalleader = " " -- Set <Space> as <LocalLeader>

require("lazy").setup("plugins", {
	install = { colorscheme = { "catppuccin" } },
	ui = { border = "rounded" },
})

-- Load modules not loaded by lazy
-- require("config.options")
-- require("config.keymaps")
-- require("config.commands")
-- require("config.diagnostic")
