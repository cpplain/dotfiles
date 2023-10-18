-- Use default Neovim config if running in VS Code
if vim.g.vscode then
    print("Neovim running in VS Code. Using default Neovim config.")
    return
end

-----------------------
-- Editor Configuration
-----------------------

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true

----------
-- Plugins
----------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "catppuccin/nvim", name = "catppuccin" },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    },
}, {})

-----------------------
-- Plugin Configuration
-----------------------

vim.cmd.colorscheme("catppuccin")

---
-- Treesitter
---
-- `:help nvim-treesitter`
require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "go", "lua", "python", "javascript", "query", "vim", "vimdoc" },
    highlight = { enable = true },
})
