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
				ensure_installed = {
					"bash-language-server",
					"css-lsp",
					"eslint_d",
					"gopls",
					"html-lsp",
					"json-lsp",
					"lua-language-server",
					"marksman",
					"prettierd",
					"pyright",
					"ruff",
					"ruff-lsp",
					"shfmt",
					"stylua",
					"taplo",
					"typescript-language-server",
					"vim-language-server",
					"yaml-language-server",
				},
			})
		end,
	},
}
