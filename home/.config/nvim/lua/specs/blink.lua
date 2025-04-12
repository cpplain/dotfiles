return {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "*",
    event = { "InsertEnter", "CmdlineEnter" },

    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
        completion = {
            menu = { border = "rounded" },
            documentation = { window = { border = "rounded" } },
            ghost_text = { enabled = false },
        },
        sources = {
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },
            },
        },
        signature = { window = { border = "rounded" } },
    },
}
