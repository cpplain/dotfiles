--
--[[ Fuzzy finder and file browser ]]
--

return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			-- "folke/noice.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
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
				},
			})
			telescope.load_extension("file_browser")
			telescope.load_extension("fzf")
			-- telescope.load_extension("noice")

			vim.keymap.set("n", "<Leader>fB", "<Cmd>Telescope file_browser<CR>")
			vim.keymap.set("n", "<Leader>fb", "<Cmd>Telescope buffers<CR>")
			vim.keymap.set("n", "<Leader>ff", "<Cmd>Telescope find_files<CR>")
			vim.keymap.set("n", "<Leader>ht", "<Cmd>Telescope help_tags<CR>")
			vim.keymap.set("n", "<Leader>km", "<Cmd>Telescope keymaps<CR>")
			vim.keymap.set("n", "<Leader>lg", "<Cmd>Telescope live_grep<CR>")
			-- vim.keymap.set("n", "<Leader>tn", "<Cmd>Telescope noice<CR>")
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
}
