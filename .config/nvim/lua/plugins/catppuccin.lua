-- Colorscheme
return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
		integrations = {
			lsp_trouble = true,
			noice = true,
			notify = true,
			treesitter_context = true,
		},
	},
	init = function()
		vim.cmd.colorscheme("catppuccin")
	end,
}
