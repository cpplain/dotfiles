return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
        dim_inactive = { enabled = true },
        default_integrations = false,
        integrations = {
            blink_cmp = true,
            fzf = true,
            gitsigns = true,
            lsp_trouble = true,
            -- lualine enabled in lualine config
            markdown = true,
            mason = true,
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { "italic" },
                    hints = { "italic" },
                    warnings = { "italic" },
                    information = { "italic" },
                    ok = { "italic" },
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                    ok = { "underline" },
                },
                inlay_hints = {
                    background = true,
                },
            },
            treesitter = true,
        },
    },
    config = function(_, opts)
        require("catppuccin").setup(opts)

        vim.cmd.colorscheme("catppuccin")
    end,
}
