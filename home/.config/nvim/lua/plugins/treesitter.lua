return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	branch = "main",
	lazy = false,
	config = function()
		require("nvim-treesitter").setup({
			ensure_install = {
				"bash",
				"c",
				"cpp",
				"fish",
				"gitcommit",
				"lua",
				"make",
				"markdown",
				"markdown_inline",
				"toml",
				"vim",
				"vimdoc",
				"yaml",
			},
		})

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local config = require("nvim-treesitter.config")
				local ft = vim.bo[args.buf].filetype
				local lang = vim.treesitter.language.get_lang(ft) or ft

				if vim.list_contains(config.installed_parsers(), lang) then
					vim.treesitter.start()
					vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
				end
			end,
		})
	end,
}
