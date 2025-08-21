return {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    config = function()
        ---@module 'oil'
        ---@type oil.SetupOpts
        local opts = {
            columns = {
                "permissions",
                "size",
                "mtime",
            },
            view_options = {
                show_hidden = true,
            },
        }
        require("oil").setup(opts)
        vim.keymap.set("n", "<Leader>-", "<Cmd>Oil --float<CR>", { desc = "Open file explorer (oil)" })
    end,
}
