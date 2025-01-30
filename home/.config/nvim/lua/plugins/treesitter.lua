local parsers = {
	"bash",
	"c",
	"cpp",
	"dockerfile",
	"fish",
	"gitcommit",
	"lua",
	"make",
	"markdown",
	"markdown_inline",
	"python",
	"query",
	"ruby",
	"toml",
	"vim",
	"vimdoc",
	"yaml",
}

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = parsers,
			auto_install = false,
			highlight = {
				enable = true,
			},
		})

		-- vim.api.nvim_create_autocmd("FileType", {
		-- 	callback = function(args)
		-- 		local config = require("nvim-treesitter.config")
		-- 		local ft = vim.bo[args.buf].filetype
		-- 		local lang = vim.treesitter.language.get_lang(ft) or ft
		--
		-- 		if vim.list_contains(config.installed_parsers(), lang) then
		-- 			vim.treesitter.start()
		-- 			vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
		-- 		end
		-- 	end,
		-- })
	end,
}
