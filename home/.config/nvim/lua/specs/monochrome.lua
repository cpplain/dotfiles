return {
    "cpplain/monochrome.nvim",
    priority = 1000,
    lazy = false,
    config = function()
        vim.cmd.colorscheme("monochrome")
    end,
}
