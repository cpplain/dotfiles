--
--[[ Commands ]]
--

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	group = vim.api.nvim_create_augroup("EnableWrap", { clear = true }),
	callback = function()
		vim.opt.wrap = true
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
