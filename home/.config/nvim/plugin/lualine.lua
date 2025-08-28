require("lualine").setup({
    options = {
        icons_enabled = false,
        theme = "flexoki",
        section_separators = "",
        component_separators = "",
        disabled_filetypes = { statusline = { "snacks_dashboard" } },
    },
    sections = {
        lualine_a = {
            --stylua: ignore
            { "mode", fmt = function(str) return str:sub(1, 1) end, },
        },
    },
    extensions = { "lazy", "oil", "quickfix" },
})
