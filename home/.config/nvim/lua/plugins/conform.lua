return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	cmd = "ConformInfo",
	dependencies = {
		"williamboman/mason.nvim",
	},
	opts = {
		formatters_by_ft = {
			c = { "clang-format" },
			css = { "prettierd" },
			fish = { "fish_indent" },
			go = { "goimports", "gofmt" },
			html = { "prettierd" },
			json = { "prettierd" },
			javascript = { "prettierd" },
			lua = { "stylua" },
			markdown = { "prettierd" },
			python = { "ruff_format" },
			ruby = { "rubocop" },
			sh = { "shfmt" },
			toml = { "taplo" },
			typescript = { "prettierd" },
			yaml = { "prettierd" },
		},
		format_on_save = {
			timeout_ms = 500,
		},
	},
}
