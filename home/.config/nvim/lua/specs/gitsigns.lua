return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile", "VeryLazy" },
    config = function()
        local opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
            },
            signs_staged = {
                add = { text = "+" },
                change = { text = "~" },
            },
        }
        require("gitsigns").setup(opts)
        -- stylua: ignore start
        vim.keymap.set("n", "<Leader>gn", function() require("gitsigns").nav_hunk("next") end, { desc = "Goto next hunk" })
        vim.keymap.set("n", "<Leader>gp", function() require("gitsigns").nav_hunk("prev") end, { desc = "Goto prev hunk" })
        -- stylua: ignore end
    end,
}
