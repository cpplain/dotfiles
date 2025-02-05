return {
	"saghen/blink.cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = "rafamadriz/friendly-snippets",
	version = "*",
	config = function()
		require("blink.cmp").setup({
			completion = {
				menu = { border = "rounded" },
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
		})
	end,
}
