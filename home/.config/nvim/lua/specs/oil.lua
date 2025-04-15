return {
    "stevearc/oil.nvim",
    cmd = "Oil",

    keys = {
        { "<Leader>-", "<Cmd>Oil --float<CR>", desc = "Open file explorer (oil)" },
    },

    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        view_options = {
            show_hidden = true,
        },
    },
}
