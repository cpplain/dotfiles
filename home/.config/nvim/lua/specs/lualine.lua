local M = {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
}

M.opts = {}
M.opts.options = {
    theme = "catppuccin",
    section_separators = "",
    component_separators = "",
    disabled_filetypes = { statusline = { "snacks_dashboard" } },
}
M.opts.sections = {
    lualine_b = {
        "branch",
    },
    lualine_c = {
        {
            "filename",
            path = 1,
        },
        {
            "diff",
            symbols = {
                added = " ",
                modified = " ",
                removed = " ",
            },
        },
        {
            "diagnostics",
            symbols = {
                error = " ",
                warn = " ",
                info = " ",
                hint = " ",
            },
        },
    },
    lualine_x = {
        "encoding",
        {
            "fileformat",
            symbols = {
                unix = "unix",
                dos = "dos",
                mac = "mac",
            },
        },
        "filetype",
    },
}
M.opts.extensions = { "lazy" }

return M
