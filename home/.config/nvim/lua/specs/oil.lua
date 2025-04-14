return {
    "stevearc/oil.nvim",
    event = "VeryLazy",

    keys = {
        { "<Leader>-", "<Cmd>Oil --float<CR>", desc = "Open oil file explorer" },
    },

    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        view_options = {
            show_hidden = true,
        },
    },
}
