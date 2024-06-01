--
--[[ Formatting ]]
--

return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			format_on_save = {
				timeout_ms = 500,
			},
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
				sh = { "shfmt" },
				toml = { "taplo" },
				typescript = { "prettierd" },
				yaml = { "prettierd" },
			},
		})
	end,
}
