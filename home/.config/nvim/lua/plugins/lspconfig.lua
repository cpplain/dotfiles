return {
	"nvim-lspconfig",
	opts = {
		servers = {
			gopls = {},
			marksman = {},
			ruby_lsp = {},
			rust_analyzer = {},
			taplo = {},
		},
		inlay_hints = { enabled = false },
	},
}
