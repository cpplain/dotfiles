-- Command line and notifications
return {
	"folke/noice.nvim",
	dependencies = {
		{ "MunifTanjim/nui.nvim" },
		{ "rcarriga/nvim-notify" },
		{ "nvim-treesitter/nvim-treesitter" },
	},
	opts = {
		-- cmdline = { view = "cmdline" },
		lsp = {
			progress = { enabled = false },
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		presets = {
			bottom_search = true,
			command_palette = true,
		},
	},
}
