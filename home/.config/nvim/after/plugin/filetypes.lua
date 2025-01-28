vim.filetype.add({
	extension = {
		h = "c",
	},
	pattern = {
		["B?b?rewfile.*"] = "ruby",
		[".*/git/config.*"] = "gitconfig",
	},
})
