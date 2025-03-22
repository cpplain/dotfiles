return {
	"williamboman/mason.nvim",
	opts = {
		ensure_installed = {
			"goimports",
			"markdownlint-cli2",
			"markdown-toc",
			"prettier",
			"rust-analyzer",
			"taplo",
		},
		ui = { border = "rounded" },
	},
}
