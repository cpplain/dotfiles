vim.diagnostic.config({
    virtual_lines = {
        current_line = true,
    },
    severity_sort = true,
})

vim.api.nvim_create_autocmd("DiagnosticChanged", {
    callback = function()
        vim.cmd("redrawstatus")
    end,
    desc = "Refresh statusline when diagnostics change",
})
