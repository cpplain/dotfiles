local gitsigns = require("gitsigns")

gitsigns.setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
    },
    signs_staged = {
        add = { text = "+" },
        change = { text = "~" },
    },
})

-- stylua: ignore start
---@diagnostic disable-next-line: param-type-mismatch
vim.keymap.set("n", "<Leader>gn", function() gitsigns.nav_hunk("next") end, { desc = "Goto next hunk" })
---@diagnostic disable-next-line: param-type-mismatch
vim.keymap.set("n", "<Leader>gp", function() gitsigns.nav_hunk("prev") end, { desc = "Goto prev hunk" })
-- stylua: ignore end
