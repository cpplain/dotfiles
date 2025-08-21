return {
    "cpplain/flexoki.nvim",
    -- dir = "~/git/flexoki.nvim",
    priority = 1000,
    config = function()
        ---@type flexoki.Config
        local opts = {
            plugins = {
                "gitsigns",
                "nvim_treesitter_context",
                "which_key",
            },
        }
        require("flexoki").setup(opts)
        vim.cmd.colorscheme("flexoki")
    end,
}
