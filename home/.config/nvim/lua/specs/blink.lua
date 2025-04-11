local M = {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "*",
    event = { "InsertEnter", "CmdlineEnter" },
}

M.opts_extend = { "sources.default" }

---@module 'blink.cmp'
---@type blink.cmp.Config
M.opts = {}
M.opts.completion = {
    menu = { border = "rounded" },
    documentation = { window = { border = "rounded" } },
    ghost_text = { enabled = false },
}
M.opts.sources = {
    -- default = { "lazydev", "lsp", "path", "snippets", "buffer" },
    -- default = { "lazydev" },
    providers = {
        lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100, -- show at a higher priority than lsp
        },
    },
}
M.opts.signature = { window = { border = "rounded" } }

M.config = function(_, opts)
    require("blink.cmp").setup(opts)
end

return M
