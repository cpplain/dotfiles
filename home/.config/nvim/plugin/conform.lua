local conform = require("conform")

conform.setup({
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
})

-- stylua: ignore
vim.keymap.set({ "n", "v" }, "<leader>cf", function() conform.format({ async = true }) end, { desc = "Format" })
