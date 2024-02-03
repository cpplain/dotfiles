-- Fuzzy finder and file browser
return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		{ "folke/noice.nvim" },
		{ "nvim-treesitter/nvim-treesitter" },
		{ "nvim-tree/nvim-web-devicons" },
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-file-browser.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	opts = {
		defaults = {
			layout_config = { prompt_position = "top" },
			sorting_strategy = "ascending",
			wrap_results = true,
		},
	},
	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)
		telescope.load_extension("file_browser")
		telescope.load_extension("fzf")
		telescope.load_extension("noice")

		vim.keymap.set("n", "<Leader>fB", ":Telescope file_browser<CR>", { desc = "Telescope file browser" })
		vim.keymap.set("n", "<Leader>fb", ":Telescope buffers<CR>", { desc = "Telescope find buffers" })
		vim.keymap.set("n", "<Leader>ff", ":Telescope find_files<CR>", { desc = "Telescope find files" })
		vim.keymap.set("n", "<Leader>fg", ":Telescope live_grep<CR>", { desc = "Telescope live grep" })
		vim.keymap.set("n", "<Leader>fh", ":Telescope help_tags<CR>", { desc = "Telescope find help tags" })
		vim.keymap.set("n", "<Leader>fk", ":Telescope keymaps<CR>", { desc = "Telescope keymaps" })
		vim.keymap.set("n", "<Leader>fn", ":Telescope noice<CR>", { desc = "Telescope noice" })
	end,
}
