-- Fuzzy Finder

return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					layout_config = {
						prompt_position = "top",
					},
					sorting_strategy = "ascending",
					wrap_results = true,
					file_ignore_patterns = {
						".git",
					},
				},
				pickers = {
					find_files = {
						hidden = true,
					},
					live_grep = {
						additional_args = {
							"--hidden",
						},
					},
				},
			})
			telescope.load_extension("fzf")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<Leader>fb", builtin.buffers)
			vim.keymap.set("n", "<Leader>ff", builtin.find_files)
			vim.keymap.set("n", "<Leader>ht", builtin.help_tags)
			vim.keymap.set("n", "<Leader>km", builtin.keymaps)
			vim.keymap.set("n", "<Leader>lg", builtin.live_grep)
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
}
