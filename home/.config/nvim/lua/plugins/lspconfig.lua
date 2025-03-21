return {
	"nvim-lspconfig",
	opts = {
		servers = {
			ruby_lsp = {},
			rust_analyzer = {},
			taplo = {},
		},
		inlay_hints = { enabled = false },
	},
}
