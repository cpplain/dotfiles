return {
	"folke/snacks.nvim",
	opts = {
		indent = {
			-- disable indent guides
			enabled = false,
		},
		picker = {
			sources = {
				explorer = {
					-- display hidden files
					hidden = true,
				},
				files = {
					-- search hidden files
					hidden = true,
				},
				grep = {
					-- search hidden files
					hidden = true,
				},
			},
		},
	},
}
