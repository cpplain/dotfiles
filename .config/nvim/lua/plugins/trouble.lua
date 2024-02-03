-- Diagnostics
return {
	"folke/trouble.nvim",
	opts = {
		icons = false,
		use_diagnostic_signs = true,
	},
	init = function()
		vim.diagnostic.config({
			virtual_text = {
				prefix = "●",
			},
			float = { border = "rounded" },
			severity_sort = true,
		})
	end,
}
