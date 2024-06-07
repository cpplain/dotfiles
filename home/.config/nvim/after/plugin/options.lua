-- Custom Options

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
