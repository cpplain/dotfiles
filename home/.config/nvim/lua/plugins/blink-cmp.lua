return {
	"saghen/blink.cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = "rafamadriz/friendly-snippets",
	version = "*",
	opts = {
		completion = {
			menu = {
				border = "rounded",
				auto_show = false,
			},
			documentation = { window = { border = "rounded" } },
		},
		signature = { window = { border = "rounded" } },
		sources = {
			default = { "lazydev", "lsp", "path", "snippets", "buffer" },
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100, -- show at a higher priority than lsp
				},
			},
		},
	},
}
