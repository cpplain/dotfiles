return {
	"nvim-lspconfig",
	opts = {
		servers = {
			marksman = {},
			ruby_lsp = {},
			rust_analyzer = {},
			taplo = {},
		},
		inlay_hints = { enabled = false },
	},
}
