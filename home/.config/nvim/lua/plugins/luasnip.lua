return {
	"L3MON4D3/LuaSnip",
	build = "make install_jsregexp",
	dependencies = { "rafamadriz/friendly-snippets" },
	lazy = true,
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load()
	end,
}
