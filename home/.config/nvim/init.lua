--
--[[ Options ]]
--

-- Leader
vim.g.mapleader = " " -- Set <Space> as <Leader>
vim.g.maplocalleader = " " -- Set <Space> as <LocalLeader>

-- Indentation and wrapping
vim.opt.breakindent = true -- Wrapped line repeats indent
vim.opt.expandtab = true -- Use spaces when tab is inserted
vim.opt.linebreak = true -- Wrap lines are word boundary
vim.opt.shiftwidth = 4 -- Number of spaces for autoindent
vim.opt.tabstop = 4 -- Number of spaces tab uses
vim.opt.wrap = false -- Long lines wrap to the next line

-- OS integration
vim.opt.clipboard = "unnamedplus" -- Sync Neovim and OS clipboard

-- Search
vim.opt.hlsearch = false -- Highlight matches with last search pattern
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true -- Do not ignore case when pattern has uppercase

-- Spelling
vim.opt.spell = true
vim.opt.spelllang = "en_us"

-- UI
vim.opt.completeopt = "menu,menuone,noselect" -- Options for Insert mode completion
vim.opt.number = true -- Print the line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.signcolumn = "yes" -- Always display the sign column
vim.opt.splitbelow = true -- Split new window below current
vim.opt.splitright = true -- Split new window right of current
vim.opt.termguicolors = true -- Enable 24-bit RGB color

--
--[[ Keymaps ]]
--

-- Diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist)

-- LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help)
vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename)

-- Moving text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Wrapping lines
vim.keymap.set("n", "<Leader>w", "<Cmd>set wrap!<CR>")

--
--[[ Commands ]]
--

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	group = vim.api.nvim_create_augroup("EnableWrap", { clear = true }),
	callback = function()
		vim.opt.wrap = true
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

--
--[[ Plugins ]]
--

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

require("lazy").setup({
	spec = { { import = "plugins" } },
	install = { colorscheme = { "catppuccin" } },
	ui = { border = "rounded" },
	checker = { enabled = true },
})
