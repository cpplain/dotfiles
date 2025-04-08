return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    opts = {
        ensure_installed = {
            "bash",
            "c",
            "cpp",
            "dockerfile",
            "fish",
            "gitcommit",
            "lua",
            "make",
            "markdown",
            "markdown_inline",
            "python",
            "puppet",
            "query",
            "ruby",
            "toml",
            "vim",
            "vimdoc",
            "yaml",
        },
        auto_install = false,
        highlight = {
            enable = true,
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
