vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.breakindent = true
vim.opt.expandtab = true
vim.opt.linebreak = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.wrap = false

vim.opt.clipboard = "unnamedplus"

vim.opt.completeopt = "menu,menuone,noselect"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.number = true
-- vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

vim.opt.spelllang = "en_us"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.termguicolors = true

vim.filetype.add({
	extension = {
		h = "c",
	},
	pattern = {
		["B?b?rewfile.*"] = "ruby",
		[".*/git/config.*"] = "gitconfig",
	},
})
