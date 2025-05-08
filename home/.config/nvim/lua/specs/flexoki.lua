return {
    "cpplain/flexoki.nvim",
    -- dir = "~/git/flexoki.nvim",
    lazy = false,
    priority = 1000,

    opts = {
        plugins = {
            "gitsigns",
            "which_key",
        },
    },
    config = function(_, opts)
        require("flexoki").setup(opts)
        vim.cmd.colorscheme("flexoki")
    end,
}
