return {
	"folke/snacks.nvim",
	opts = {
		indent = {
			enabled = false, -- disable indent guides
		},
		picker = {
			sources = {
				explorer = {
					hidden = true, -- display hidden files
				},
				files = {
					hidden = true, -- search hidden files
				},
				grep = {
					hidden = true, -- search hidden files
				},
			},
		},
	},
}
