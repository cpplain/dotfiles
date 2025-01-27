return {
	"saghen/blink.cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = "rafamadriz/friendly-snippets",
	version = "*",
	config = function()
		require("blink.cmp").setup({
			completion = {
				menu = { border = "single" },
				documentation = { window = { border = "single" } },
			},
			signature = { window = { border = "single" } },
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
