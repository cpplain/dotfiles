--
--[[ Server, linter, and formatter package manager ]]
--

return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
				},
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		build = ":MasonToolsUpdate",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = require("config.lang_tools").packages(),
			})
		end,
	},
}
