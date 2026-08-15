require("oil").setup({
    columns = {
        "permissions",
        "size",
        "mtime",
    },
    view_options = {
        show_hidden = true,
    },
})

vim.keymap.set("n", "<Leader>-", "<Cmd>Oil --float<CR>", { desc = "Open file explorer (oil)" })
