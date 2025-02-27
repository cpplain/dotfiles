-- Buffers
vim.keymap.set("n", "]b", "<Cmd>bnext<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "[b", "<Cmd>bprevious<CR>", { desc = "Previous Buffer" })

-- Diagnostics/Trouble
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
vim.keymap.set("n", "<Leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.keymap.set("n", "<leader>xx", "<Cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set(
	"n",
	"<leader>xX",
	"<Cmd>Trouble diagnostics toggle filter.buf=0<CR>",
	{ desc = "Buffer Diagnostics (Trouble)" }
)
vim.keymap.set("n", "<leader>cs", "<Cmd>Trouble symbols toggle<CR>", { desc = "Symbols (Trouble)" })
vim.keymap.set("n", "<leader>cS", "<Cmd>Trouble lsp toggle<CR>", { desc = "LSP references/definitions/... (Trouble)" })
vim.keymap.set("n", "<leader>xL", "<Cmd>Trouble loclist toggle<CR>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", "<Cmd>Trouble qflist toggle<CR>", { desc = "Quickfix List (Trouble)" })

-- Lazy
vim.keymap.set("n", "<Leader>l", "<Cmd>Lazy<CR>", { desc = "Lazy" })

-- Lines (indent)
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Lines (move)
vim.keymap.set("n", "<A-j>", "<Cmd>move +1<CR>==", { desc = "Move Line Down" })
vim.keymap.set("n", "<A-k>", "<Cmd>move -2<CR>==", { desc = "Move Line Up" })
vim.keymap.set("v", "<A-j>", ":move '>+1<CR>gv=gv", { desc = "Move Line(s) Down", silent = true })
vim.keymap.set("v", "<A-k>", ":move '<-2<CR>gv=gv", { desc = "Move Line(s) Up", silent = true })

-- Lines (wrap)
vim.keymap.set("n", "<Leader>w", "<Cmd>set wrap!<CR>")

-- Scroll
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Search
vim.keymap.set("n", "<Leader>nh", "<Cmd>noh<CR>")

--Spelling
vim.keymap.set("n", "<Leader>sp", "<Cmd>set spell!<CR>")

-- Windows (resize)
vim.keymap.set("n", "<C-k>", "<Cmd>resize +2<CR>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-j>", "<Cmd>resize -2<CR>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-l>", "<Cmd>vertical resize +2<CR>", { desc = "Increase Window Width" })
vim.keymap.set("n", "<C-h>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease Window Width" })
