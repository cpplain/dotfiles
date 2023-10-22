-- https://github.com/nvim-treesitter/nvim-treesitter
-- See `:help nvim-treesitter`
local M = { "nvim-treesitter/nvim-treesitter" }

M.build = ":TSUpdate"

-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
-- See `:help nvim-treesitter-textobjects`
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

        -- See `:help nvim-treesitter-modules`
        highlight = { enable = true },

        -- See `:help nvim-treesitter-textobjects-modules`
        textobjects = {
            move = {
                enable = true,
                set_jumps = true,
                goto_next = {
                    ["]p"] = "@parameter.inner",
                    ["]m"] = "@function.outer",
                    ["]]"] = "@class.outer",
                },
                goto_previous = {
                    ["[p"] = "@parameter.inner",
                    ["[m"] = "@function.outer",
                    ["[["] = "@class.outer",
                },
            },
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ["<leader>a"] = "@parameter.inner",
                    ["<leader>f"] = "@function.outer",
                },
                swap_previous = {
                    ["<leader>A"] = "@parameter.inner",
                    ["<leader>F"] = "@function.outer",
                },
            },
        },
    })
end

return M
