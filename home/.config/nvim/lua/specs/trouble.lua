return {
    "folke/trouble.nvim",
    cmd = { "Trouble" },

    -- stylua: ignore
    keys = {
        { "<Leader>xx", "<Cmd>Trouble diagnostics toggle<CR>", desc = "Open diagnostics (trouble)" },
        { "<Leader>xX", "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Open buffer diagnostics (trouble)" },
        { "<Leader>cs", "<Cmd>Trouble symbols toggle<CR>", desc = "Open symbols (trouble)" },
        { "<Leader>cS", "<Cmd>Trouble lsp toggle<CR>", desc = "Open LSP references/definitions/... (trouble)" },
        { "<Leader>xL", "<Cmd>Trouble loclist toggle<CR>", desc = "Open location List (trouble)" },
        { "<Leader>xQ", "<Cmd>Trouble qflist toggle<CR>", desc = "Open quickfix List (trouble)" },
        {
            "[q",
            function()
                if require("trouble").is_open() then
                    ---@diagnostic disable-next-line: missing-parameter, missing-fields
                    require("trouble").prev({ skip_groups = true, jump = true })
                else
                    pcall(vim.cmd.cprev)
                end
            end,
            desc = "Previous trouble/quickfix item"
        },
        {
            "]q",
            function()
                if require("trouble").is_open() then
                    ---@diagnostic disable-next-line: missing-parameter, missing-fields
                    require("trouble").next({ skip_groups = true, jump = true })
                else
                    pcall(vim.cmd.cnext)
                end
            end,
            desc = "Next trouble/quickfix item"
        },
    },

    opts = {
        -- stylua: ignore
        icons = {
            ---@type trouble.Indent.symbols
            indent = {
                -- top           = "│ ",
                -- middle        = "├╴",
                -- last          = "└╴",
                top           = "  ",
                middle        = "  ",
                last          = "  ",
                fold_open     = "- ",
                fold_closed   = "+ ",
                ws            = "  ",
            },
            folder_closed   = "",
            folder_open     = "",
            kinds = {},
        },
    },
}
