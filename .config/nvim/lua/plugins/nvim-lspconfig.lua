-- Language server
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "folke/neodev.nvim", opts = {} },
		{ "hrsh7th/nvim-cmp" },
	},
	config = function()
		local servers = {
			gopls = {},
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},
			tsserver = {},
		}

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local border = "rounded"
		local handlers = {
			["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
			["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
		}
		require("lspconfig.ui.windows").default_options.border = border

		local on_attach = function(_, bufnr)
			local function keymap(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
			end

			keymap("n", "gd", vim.lsp.buf.definition, "Goto definition")
			keymap("n", "gi", vim.lsp.buf.implementation, "Goto implementation")
			keymap("n", "gr", vim.lsp.buf.references, "Goto references")
			keymap("n", "gt", vim.lsp.buf.type_definition, "Goto type definition")
			keymap("n", "K", vim.lsp.buf.hover, "Hover information")
			keymap("i", "<C-k>", vim.lsp.buf.signature_help, "Signature information")
			keymap({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, "Code action")
			keymap("n", "<Leader>rn", vim.lsp.buf.rename, "Rename symbol")
		end

		for server, server_opts in pairs(servers) do
			server_opts.capabilities = capabilities
			server_opts.handlers = handlers
			server_opts.on_attach = on_attach

			require("lspconfig")[server].setup(server_opts)
		end
	end,
}
