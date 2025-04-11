local M = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = vim.fn.argc(-1) == 0,
    event = { "BufReadPost", "BufNewFile", "VeryLazy" },
}

M.opts = {
    textobjects = {
        --stylua: ignore
        move = {
            enable = true,
            goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
            goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
            goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
            goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
        },
    },
}

M.config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
end

return M
