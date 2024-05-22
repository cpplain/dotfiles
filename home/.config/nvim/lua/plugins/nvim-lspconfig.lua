--
--[[ Language server configuration ]]
--

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"folke/neodev.nvim",
		"hrsh7th/nvim-cmp",
	},
	config = function()
		local servers = {
			bashls = {},
			cssls = {},
			gopls = {},
			html = {},
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},
			jsonls = {},
			marksman = {},
			pyright = {},
			ruff_lsp = {
				on_attach = function(client, _)
					client.server_capabilities.hoverProvider = false
				end,
			},
			taplo = {},
			tsserver = {
				settings = {
					completions = {
						completeFunctionCalls = true,
					},
				},
			},
			vimls = {},
			yamlls = {},
		}

		require("neodev").setup()

		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		for name, opts in pairs(servers) do
			opts.capabilities = capabilities

			lspconfig[name].setup(opts)
		end

		require("lspconfig.ui.windows").default_options.border = "rounded"
	end,
}
