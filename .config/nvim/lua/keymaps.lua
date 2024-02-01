-- Diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic message" })
vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Moving text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down and reindent" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up and reindent" })

-- Plugin manager
vim.keymap.set("n", "<Leader>ll", ":Lazy<CR>", { desc = "Open plugin manager" })
vim.keymap.set("n", "<Leader>lp", ":Lazy profile<CR>", { desc = "Run startup profile" })
vim.keymap.set("n", "<Leader>lu", ":Lazy update<CR>", { desc = "Update plugins" })

-- Scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
