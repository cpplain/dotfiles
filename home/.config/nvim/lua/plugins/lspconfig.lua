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
	ts_ls = {
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
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local border = "rounded"
		local handlers = {
			["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
			["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
		}
		require("lspconfig.ui.windows").default_options.border = border

		for name, opts in pairs(servers) do
			opts.capabilities = capabilities
			opts.handlers = handlers

			lspconfig[name].setup(opts)
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("LspMappings", { clear = true }),
			callback = function(args)
				local opts = { buffer = args.buf }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
			end,
		})
	end,
}
