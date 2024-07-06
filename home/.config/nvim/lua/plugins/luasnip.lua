return {
	"L3MON4D3/LuaSnip",
	build = "make install_jsregexp",
	dependencies = { "rafamadriz/friendly-snippets" },
	lazy = true,
	config = function()
		local ls = require("luasnip")

		ls.config.set_config()

		require("luasnip.loaders.from_vscode").lazy_load()

		vim.keymap.set({ "i", "s" }, "<C-k>", function()
			if ls.expand_or_jumpable() then
				ls.expand_or_jump()
			end
		end)

		vim.keymap.set({ "i", "s" }, "<C-j>", function()
			if ls.jumpable(-1) then
				ls.jump(-1)
			end
		end)
	end,
}
