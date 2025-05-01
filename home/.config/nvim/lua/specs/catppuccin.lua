return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,

    opts = {
        dim_inactive = { enabled = true },
        default_integrations = false,
        integrations = {
            blink_cmp = true,
            gitsigns = true,
            lsp_trouble = true,
            -- lualine enabled in lualine config
            markdown = true,
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
            render_markdown = true,
            snacks = { enabled = true },
            treesitter = true,
            treesitter_context = true,
            which_key = true,
        },
    },

    config = function(_, opts)
        require("catppuccin").setup(opts)

        vim.cmd.colorscheme("catppuccin")
    end,
}
