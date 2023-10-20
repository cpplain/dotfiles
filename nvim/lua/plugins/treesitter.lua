local M = { "nvim-treesitter/nvim-treesitter" }

M.build = ":TSUpdate"
M.dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" }

function M.config()
    require("nvim-treesitter.configs").setup({
        ensure_installed = {
            "c",
            "go",
            "lua",
            "python",
            "javascript",
            "query",
            "vim",
            "vimdoc",
        },
        highlight = {
            enable = true,
        },
    })
end

return M
