require("lualine").setup({
    options = {
        icons_enabled = false,
        theme = "flexoki",
        section_separators = "",
        component_separators = "",
        disabled_filetypes = { statusline = { "snacks_dashboard" } },
    },
    extensions = { "lazy", "oil", "quickfix" },
})
