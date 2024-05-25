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
		local servers = require("config.lang_tools").lsp_servers()

		require("neodev").setup()

		local border = "rounded"
		local handlers = {
			["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
			["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
		}

		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		for name, opts in pairs(servers) do
			opts.capabilities = capabilities
			opts.handlers = handlers

			lspconfig[name].setup(opts)
		end

		require("lspconfig.ui.windows").default_options.border = border
	end,
}
