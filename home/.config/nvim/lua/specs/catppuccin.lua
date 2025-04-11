local M = {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
}

M.opts = {
    dim_inactive = { enabled = true },
    default_integrations = false,
}
M.opts.integrations = {
    blink_cmp = true,
    flash = true,
    gitsigns = true,
    lsp_trouble = true,
    -- lualine enabled in lualine config
    mason = true,
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
    noice = true,
    render_markdown = true,
    snacks = { enabled = true },
    treesitter = true,
    treesitter_context = true,
    which_key = true,
}

M.config = function(_, opts)
    require("catppuccin").setup(opts)

    vim.cmd.colorscheme("catppuccin")
end

return M
