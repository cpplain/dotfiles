--
--[[ Linting ]]
--

return {
	"mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = {
			fish = { "fish" },
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
		}

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
			group = vim.api.nvim_create_augroup("Lint", { clear = true }),
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
