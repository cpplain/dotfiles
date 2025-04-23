return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
        options = {
            icons_enabled = false,
            -- theme = "catppuccin",
            theme = "monochrome",
            section_separators = "",
            component_separators = "",
            disabled_filetypes = { statusline = { "snacks_dashboard" } },
        },
        extensions = { "lazy", "oil", "quickfix", "trouble" },
    },
}
