return {
    "cpplain/flexoki.nvim",
    -- dir = "~/git/flexoki.nvim",
    lazy = false,
    priority = 1000,

    ---@type flexoki.Config
    opts = {
        plugins = {
            "gitsigns",
            "nvim_treesitter_context",
            "which_key",
        },
    },
    config = function(_, opts)
        require("flexoki").setup(opts)
        vim.cmd.colorscheme("flexoki")
    end,
}
