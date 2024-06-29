--
--[[ Diagnostics ]]
--

return {
	"folke/trouble.nvim",
	enabled = false,
	config = function()
		vim.diagnostic.config({
			virtual_text = {
				prefix = "●",
			},
			float = {
				border = "rounded",
			},
			severity_sort = true,
		})

		require("trouble").setup({
			icons = false,
			use_diagnostic_signs = true,
		})
	end,
}
