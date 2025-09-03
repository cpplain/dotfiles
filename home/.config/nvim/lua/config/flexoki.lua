require("flexoki").setup({
    groups = {
        "gitsigns",
    },
    highlight_override = function(colors)
        return {
            StatusLineModeN = { fg = colors.blue },
            StatusLineModeI = { fg = colors.green },
            StatusLineModeV = { fg = colors.magenta },
            StatusLineModeR = { fg = colors.red },
            StatusLineModeC = { fg = colors.orange },
            StatusLineModeT = { fg = colors.green },
        }
    end,
})

vim.cmd.colorscheme("flexoki")
