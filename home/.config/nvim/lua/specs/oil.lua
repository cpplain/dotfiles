return {
    "stevearc/oil.nvim",
    event = "VeryLazy",

    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        columns = {
            "icon",
            "permissions",
            "size",
            "mtime",
        },
        view_options = {
            show_hidden = true,
        },
    },
}
