return {
	"stevearc/oil.nvim",
	config = function()
		require("oil").setup({
			columns = {
				"permissions",
				"size",
				"mtime",
			},
			view_options = {
				show_hidden = true,
			},
		})
	end,
}
