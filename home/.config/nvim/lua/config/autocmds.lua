vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("SetTextIndent", { clear = true }),
    pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
    end,
})
