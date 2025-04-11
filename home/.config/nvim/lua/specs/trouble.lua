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

    keys = {
        { "<Leader>xx", "<Cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
        { "<Leader>xX", "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer Diagnostics (Trouble)" },
        { "<Leader>cs", "<Cmd>Trouble symbols toggle<CR>", desc = "Symbols (Trouble)" },
        { "<Leader>cS", "<Cmd>Trouble lsp toggle<CR>", desc = "LSP references/definitions/... (Trouble)" },
        { "<Leader>xL", "<Cmd>Trouble loclist toggle<CR>", desc = "Location List (Trouble)" },
        { "<Leader>xQ", "<Cmd>Trouble qflist toggle<CR>", desc = "Quickfix List (Trouble)" },
        { "[q", prev, desc = "Previous Trouble/Quickfix Item" },
        { "]q", next, desc = "Next Trouble/Quickfix Item" },
    },

    opts = {
        modes = {
            lsp = {
                win = { position = "right" },
            },
        },
    },
}
