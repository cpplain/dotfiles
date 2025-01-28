vim.filetype.add({
	pattern = {
		["B?b?rewfile.*"] = "ruby",
		[".*/git/config.*"] = "gitconfig",
	},
})
