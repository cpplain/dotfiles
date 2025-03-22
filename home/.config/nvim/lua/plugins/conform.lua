return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			css = { "prettier" },
			go = { "goimports" },
			html = { "prettier" },
			javascript = { "prettier" },
			json = { "prettier" },
			jsonc = { "prettier" },
			markdown = { "prettier", "markdownlint-cli2", "markdown-toc" },
			ruby = { "rubocop" },
			rust = { "rustfmt" },
			toml = { "taplo" },
			typescript = { "prettier" },
			yaml = { "prettier" },
		},
	},
}
