return {
    "cpplain/selenized.nvim",
    -- dir = "~/git/selenized.nvim",
    priority = 1000,
    lazy = false,
    config = function()
        vim.cmd.colorscheme("selenized")
    end,
}
