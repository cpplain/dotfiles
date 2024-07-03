-- Bootstrap plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Must be set before initializing lazy
vim.g.mapleader = " " -- Set <Space> as <Leader>
vim.g.maplocalleader = " " -- Set <Space> as <LocalLeader>

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	install = { colorscheme = { "catppuccin" } },
	ui = { border = "rounded" },
})
