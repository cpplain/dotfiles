return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"saghen/blink.cmp",
		"williamboman/mason.nvim",
	},
	opts = {
		servers = {
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
			rubocop = {},
			ruff = {
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
		},
		border = "rounded",
		diagnostic = {
			virtual_text = {
				prefix = "●",
			},
			float = {
				border = "rounded",
			},
			severity_sort = true,
		},
	},
	config = function(_, opts)
		local lspconfig = require("lspconfig")
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		local handlers = {
			["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = opts.border }),
			["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = opts.border }),
		}
		require("lspconfig.ui.windows").default_options.border = opts.border

		for name, server_opts in pairs(opts.servers) do
			opts.capabilities = capabilities
			opts.handlers = handlers

			lspconfig[name].setup(server_opts)
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("LspMappings", { clear = true }),
			callback = function(args)
				local map_opts = { buffer = args.buf }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, map_opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, map_opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, map_opts)
				vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, map_opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, map_opts)
				vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, map_opts)
				vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, map_opts)
				vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, map_opts)
			end,
		})

		vim.diagnostic.config(opts.diagnostic)
	end,
}
