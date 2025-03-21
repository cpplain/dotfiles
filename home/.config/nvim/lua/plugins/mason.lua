return {
	"williamboman/mason.nvim",
	opts = {
		ensure_installed = {
			"markdownlint-cli2",
			"markdown-toc",
			"prettierd",
			"rust-analyzer",
			"taplo",
		},
		ui = { border = "rounded" },
	},
}
