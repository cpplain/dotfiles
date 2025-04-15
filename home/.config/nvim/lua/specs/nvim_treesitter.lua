return {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile", "VeryLazy" },
    cmd = { "TSInstall", "TSUpdate", "TSUpdateSync" },

    keys = {
        { "<C-Space>", desc = "Increment selection" },
        { "<BS>", desc = "Decrement selection", mode = "x" },
    },

    opts = {
        highlight = { enable = true },
        indent = { enable = true },

        ensure_installed = {
            "bash",
            "c",
            "diff",
            "git_config",
            "git_rebase",
            "gitattributes",
            "gitcommit",
            "gitignore",
            "go",
            "gomod",
            "gosum",
            "gowork",
            "html",
            "javascript",
            "jsdoc",
            "json",
            "jsonc",
            "lua",
            "luadoc",
            "luap",
            "make",
            "markdown",
            "markdown_inline",
            "printf",
            "puppet",
            "python",
            "query",
            "regex",
            "ron",
            "ruby",
            "rust",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
            "zig",
        },

        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-Space>",
                node_incremental = "<C-Space>",
                scope_incremental = false,
                node_decremental = "<BS>",
            },
        },
    },

    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)

        -- vim.api.nvim_create_autocmd("FileType", {
        --     callback = function(args)
        --         local config = require("nvim-treesitter.config")
        --         local ft = vim.bo[args.buf].filetype
        --         local lang = vim.treesitter.language.get_lang(ft) or ft
        --
        --         if vim.list_contains(config.installed_parsers(), lang) then
        --             vim.treesitter.start()
        --             vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
        --         end
        --     end,
        -- })
    end,
}
