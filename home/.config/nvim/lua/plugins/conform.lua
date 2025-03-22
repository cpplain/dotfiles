return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			css = { "prettierd" },
			go = { "goimports" },
			html = { "prettierd" },
			javascript = { "prettierd" },
			json = { "prettierd" },
			jsonc = { "prettierd" },
			markdown = { "prettierd", "markdownlint-cli2", "markdown-toc" },
			ruby = { "rubocop" },
			rust = { "rustfmt" },
			toml = { "taplo" },
			typescript = { "prettierd" },
			yaml = { "prettierd" },
		},
	},
}
