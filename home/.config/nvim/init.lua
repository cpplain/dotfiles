vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.breakindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.conceallevel = 0
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.linebreak = true
vim.opt.list = false
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.scrolloff = 4
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.spelllang = { "en" }
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.wrap = false

local map = vim.keymap.set

-- better indenting
map("v", "<", "<gv", { desc = "Shift lines left" })
map("v", ">", ">gv", { desc = "Shift lines right" })

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Move cursor down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Move cursor up", expr = true, silent = true })

-- clear search hightlight on escape
map("n", "<Esc>", function()
    vim.cmd("noh")
    return "<Esc>"
end, { expr = true, desc = "Escape and clear search highlight" })

-- lazy
map("n", "<Leader>l", "<Cmd>Lazy<CR>", { desc = "Open lazy" })

-- move lines
map("n", "<A-j>", "<Cmd>move +1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<Cmd>move -2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":move '>+1<CR>gv=gv", { desc = "Move lines down", silent = true })
map("v", "<A-k>", ":move '<-2<CR>gv=gv", { desc = "Move lines up", silent = true })

-- resize window
map("n", "<C-k>", "<Cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-j>", "<Cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-l>", "<Cmd>vertical resize +2<CR>", { desc = "Increase window width" })
map("n", "<C-h>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease window width" })

vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("HighlightOnYank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = { { import = "specs" } },
    defaults = {
        lazy = false,
        version = false,
    },
    rocks = { enabled = false },
    install = { colorscheme = { "catppuccin" } },
    ui = { border = "rounded" },
    change_detection = { notify = false },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                -- "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
