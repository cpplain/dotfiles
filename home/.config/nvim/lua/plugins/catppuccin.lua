return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			integrations = {
				lsp_trouble = true,
				treesitter_context = true,
			},
		})

		vim.cmd.colorscheme("catppuccin")
	end,
}
