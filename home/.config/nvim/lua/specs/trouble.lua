local prev = function()
    if require("trouble").is_open() then
        require("trouble").prev({ skip_groups = true, jump = true })
    else
        local ok, err = pcall(vim.cmd.cprev)
        if not ok then
            vim.notify(err, vim.log.levels.ERROR)
        end
    end
end

local next = function()
    if require("trouble").is_open() then
        require("trouble").next({ skip_groups = true, jump = true })
    else
        local ok, err = pcall(vim.cmd.cnext)
        if not ok then
            vim.notify(err, vim.log.levels.ERROR)
        end
    end
end

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
        { "[q", prev, desc = "Previous trouble/quickfix item" },
        { "]q", next, desc = "Next trouble/quickfix item" },
    },

    opts = {
        modes = {
            lsp = {
                win = { position = "right" },
            },
        },
    },
}
