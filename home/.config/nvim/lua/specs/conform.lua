return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",

    -- stylua: ignore
    keys = {
        { "<leader>cf", function() require("conform").format({ async = true }) end, mode = { "n", "v" }, desc = "Format" },
    },

    opts = {
        formatters_by_ft = {
            css = { "prettier" },
            fish = { "fish_indent" },
            go = { "goimports" },
            html = { "prettier" },
            javascript = { "prettier" },
            json = { "prettier" },
            jsonc = { "prettier" },
            lua = { "stylua" },
            markdown = { "prettier", "markdownlint-cli2", "markdown-toc" },
            rust = { "rustfmt" },
            sh = { "shfmt" },
            toml = { "taplo" },
            typescript = { "prettier" },
            yaml = { "prettier" },
            zig = { "zigfmt" },
        },
        format_on_save = function()
            if vim.g.autoformat then
                return {
                    lsp_format = "fallback",
                    timeout_ms = 500,
                }
            end
            return nil
        end,
    },
}
