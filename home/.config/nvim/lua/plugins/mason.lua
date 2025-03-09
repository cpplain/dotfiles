return {
	"williamboman/mason.nvim",
	opts = {
		ensure_installed = {
			"rust-analyzer",
			"taplo",
		},
		ui = { border = "rounded" },
	},
}
