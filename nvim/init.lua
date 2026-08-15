vim.cmd.colorscheme("flexoki")

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
vim.opt.ruler = false
vim.opt.scrolloff = 4
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.showcmdloc = "statusline"
vim.opt.showmode = false
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.winborder = "rounded"
vim.opt.wrap = false

vim.g.mapleader = " "
vim.g.maplocalleader = " "

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

map("n", "<Leader>pu", function()
    vim.pack.update()
end, { desc = "Update plugins" })

vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("UserHighlight", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.g.loaded_gzip = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tohtml = 1
vim.g.loaded_tutor = 1
vim.g.loaded_zipPlugin = 1

vim.api.nvim_create_autocmd("PackChanged", {
    desc = "Run :TSUpdate after nvim-treesitter install/update",
    callback = function(ev)
        local data = ev.data
        if data.spec.name == "nvim-treesitter" and (data.kind == "install" or data.kind == "update") then
            vim.cmd("TSUpdate")
        end
    end,
})

vim.pack.add({
    { src = "https://github.com/folke/snacks.nvim" },
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/stevearc/oil.nvim" },
})

require("config.snacks")
require("config.blink")
require("config.conform")
require("config.diagnostic")
require("config.gitsigns")
require("config.lsp")
require("config.nvim_treesitter")
require("config.oil")

vim.o.statusline = "%!v:lua.require('config.statusline').build()"

local statusline_group = vim.api.nvim_create_augroup("UserStatusline", { clear = true })

vim.api.nvim_create_autocmd("DiagnosticChanged", {
    group = statusline_group,
    command = "redrawstatus!",
    desc = "Redraw statusline when diagnostics change",
})

vim.api.nvim_create_autocmd("User", {
    group = statusline_group,
    pattern = "GitSignsUpdate",
    command = "redrawstatus!",
    desc = "Redraw statusline when gitsigns updates",
})
