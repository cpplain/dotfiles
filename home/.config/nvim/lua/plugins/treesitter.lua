return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	branch = "main",
	lazy = false,
	config = function()
		require("nvim-treesitter").setup({
			auto_install = true,
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "<filetype>",
			group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
			callback = function()
				vim.treesitter.start()
				vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
			end,
		})
	end,
}
