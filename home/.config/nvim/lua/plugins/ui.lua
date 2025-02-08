return {
	{
		"akinsho/bufferline.nvim",
		enabled = false,
	},
	{
		"snacks.nvim",
		opts = {
			indent = { enabled = false },
		},
	},
	{
		"folke/noice.nvim",
		opts = {
			cmdline = {
				view = "cmdline",
			},
			presets = {
				command_palette = false,
				lsp_doc_border = true,
			},
		},
	},
}
