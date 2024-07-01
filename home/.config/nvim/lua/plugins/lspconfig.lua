local servers = {
	bashls = {},
	clangd = {},
	cssls = {},
	gopls = {},
	html = {},
	jsonls = {},
	lua_ls = {
		settings = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
			},
		},
	},
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

return {
	"neovim/nvim-lspconfig",
	dependencies = { "hrsh7th/nvim-cmp" },
	config = function()
		local border = "rounded"
		local handlers = {
			["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
			["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
		}
		require("lspconfig.ui.windows").default_options.border = border

		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		for name, opts in pairs(servers) do
			opts.capabilities = capabilities
			opts.handlers = handlers

			lspconfig[name].setup(opts)
		end
	end,
}
