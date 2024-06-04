-- Setup lua_ls for Neovim

return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		config = function()
			require("lazydev").setup({
				library = {
					{ path = "luvit-meta/library", words = { "vim%.uv" } },
				},
			})
		end,
	},
	{
		"Bilal2453/luvit-meta",
		lazy = true,
	},
}
