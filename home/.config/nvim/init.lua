vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.autoformat = true

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.breakindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.linebreak = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.scrolloff = 4
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.timeoutlen = 250
vim.opt.winborder = "rounded"
vim.opt.wrap = false

local map = vim.keymap.set

map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Move cursor down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Move cursor up", expr = true, silent = true })

map("v", "<", "<gv", { desc = "Shift lines left" })
map("v", ">", ">gv", { desc = "Shift lines right" })

map("n", "<A-j>", "<Cmd>move +1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<Cmd>move -2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":move '>+1<CR>gv=gv", { desc = "Move lines down", silent = true })
map("v", "<A-k>", ":move '<-2<CR>gv=gv", { desc = "Move lines up", silent = true })

map("n", "<C-k>", "<Cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-j>", "<Cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-l>", "<Cmd>vertical resize +2<CR>", { desc = "Increase window width" })
map("n", "<C-h>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease window width" })

map("n", "<Esc>", function()
    vim.cmd("noh")
    return "<Esc>"
end, { expr = true, desc = "Escape and clear search highlight" })

map("n", "<Leader>cd", function()
    vim.api.nvim_put({ vim.trim(vim.fn.system({ "date", "-Iseconds" })) }, "c", true, true)
end, { desc = "Insert date and time (ISO 8601)" })

map("n", "<Leader>l", "<Cmd>Lazy<CR>", { desc = "Open lazy" })

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
    -- install = { colorscheme = { "catppuccin" } },
    install = { colorscheme = { "flexoki-light" } },
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
