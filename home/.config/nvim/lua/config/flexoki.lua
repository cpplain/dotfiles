require("flexoki").setup({
    groups = {
        "gitsigns",
    },
    highlight_override = function(colors)
        return {
            StatusLineModeN = { fg = colors.blue, bg = colors.blue4 },
            StatusLineModeI = { fg = colors.green, bg = colors.green4 },
            StatusLineModeV = { fg = colors.magenta, bg = colors.magenta4 },
            StatusLineModeR = { fg = colors.red, bg = colors.red4 },
            StatusLineModeC = { fg = colors.orange, bg = colors.orange4 },
            StatusLineModeT = { fg = colors.green, bg = colors.green4 },
        }
    end,
})

vim.cmd.colorscheme("flexoki")
