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

		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		for name, opts in pairs(servers) do
			opts.capabilities = capabilities

			lspconfig[name].setup(opts)
		end

		require("lspconfig.ui.windows").default_options.border = "rounded"
	end,
}
