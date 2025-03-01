local map = vim.keymap.set

-- Buffers
map("n", "]b", "<Cmd>bnext<CR>", { desc = "Next Buffer" })
map("n", "[b", "<Cmd>bprevious<CR>", { desc = "Previous Buffer" })

-- Diagnostics/Trouble
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
map("n", "<Leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "<leader>xx", "<Cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>xX", "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Buffer Diagnostics (Trouble)" })
map("n", "<leader>cs", "<Cmd>Trouble symbols toggle<CR>", { desc = "Symbols (Trouble)" })
map("n", "<leader>cS", "<Cmd>Trouble lsp toggle<CR>", { desc = "LSP references/definitions/... (Trouble)" })
map("n", "<leader>xL", "<Cmd>Trouble loclist toggle<CR>", { desc = "Location List (Trouble)" })
map("n", "<leader>xQ", "<Cmd>Trouble qflist toggle<CR>", { desc = "Quickfix List (Trouble)" })

-- Lazy
map("n", "<Leader>l", "<Cmd>Lazy<CR>", { desc = "Lazy" })

-- Lines (indent)
map("v", ">", ">gv", { desc = "Increase Line Indent" })
map("v", "<", "<gv", { desc = "Decrease Line Indent" })

-- Lines (move)
map("n", "<A-j>", "<Cmd>move +1<CR>==", { desc = "Move Line Down" })
map("n", "<A-k>", "<Cmd>move -2<CR>==", { desc = "Move Line Up" })
map("v", "<A-j>", ":move '>+1<CR>gv=gv", { desc = "Move Line(s) Down", silent = true })
map("v", "<A-k>", ":move '<-2<CR>gv=gv", { desc = "Move Line(s) Up", silent = true })

-- Lines (wrap)
map("n", "<Leader>w", "<Cmd>set wrap!<CR>", { desc = "Toggle Line Wrap" })

-- Scroll
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Search
map("n", "<Leader>nh", "<Cmd>noh<CR>")

--Spelling
map("n", "<Leader>sp", "<Cmd>set spell!<CR>", { desc = "Toggle Spelling" })

-- Windows (resize)
map("n", "<C-k>", "<Cmd>resize +2<CR>", { desc = "Increase Window Height" })
map("n", "<C-j>", "<Cmd>resize -2<CR>", { desc = "Decrease Window Height" })
map("n", "<C-l>", "<Cmd>vertical resize +2<CR>", { desc = "Increase Window Width" })
map("n", "<C-h>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease Window Width" })
