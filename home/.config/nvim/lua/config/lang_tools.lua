-- LSP servers, formatters, parsers, and packages

local languages = {
	c = {
		formatters = { c = { "clang-format" } },
		lsp_servers = { clangd = {} },
		packages = { "clangd", "clang-format" },
		parsers = { "c" },
	},

	bash = {
		formatters = { sh = { "shfmt" } },
		lsp_servers = { bashls = {} },
		packages = { "bash-language-server", "shfmt" },
		parsers = { "bash" },
	},

	css = {
		formatters = { css = { "prettierd" } },
		lsp_servers = { cssls = {} },
		packages = { "css-lsp", "prettierd" },
		parsers = { "css" },
	},

	fish = {
		formatters = { fish = { "fish_indent" } },
		parsers = { "fish" },
	},

	git = {
		parsers = { "git_config", "gitcommit", "gitignore" },
	},

	go = {
		formatters = { go = { "goimports", "gofmt" } },
		lsp_servers = { gopls = {} },
		packages = { "gopls" },
		parsers = { "go", "gomod", "gosum", "gowork" },
	},

	html = {
		formatters = { html = { "prettierd" } },
		lsp_servers = { html = {} },
		packages = { "html-lsp", "prettierd" },
		parsers = { "html" },
	},

	javascript = {
		formatters = {
			javascript = { "prettierd" },
			typescript = { "prettierd" },
		},
		lsp_servers = {
			tsserver = {
				settings = {
					completions = {
						completeFunctionCalls = true,
					},
				},
			},
		},
		packages = { "prettierd", "typescript-language-server" },
		parsers = { "javascript", "jsdoc", "typescript" },
	},

	json = {
		formatters = { json = { "prettierd" } },
		lsp_servers = { jsonls = {} },
		packages = { "json-lsp", "prettierd" },
		parsers = { "json" },
	},

	lua = {
		formatters = { lua = { "stylua" } },
		lsp_servers = {
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},
		},
		packages = { "lua-language-server", "stylua" },
		parsers = { "lua", "luadoc" },
	},

	make = {
		parsers = { "make" },
	},

	markdown = {
		formatters = { markdown = { "prettierd" } },
		lsp_servers = { marksman = {} },
		packages = { "marksman", "prettierd" },
		parsers = { "markdown", "markdown_inline" },
	},

	python = {
		formatters = { python = { "ruff_format" } },
		lsp_servers = {
			pyright = {},
			ruff_lsp = {
				on_attach = function(client, _)
					client.server_capabilities.hoverProvider = false
				end,
			},
		},
		packages = { "pyright", "ruff", "ruff-lsp" },
		parsers = { "python" },
	},

	regex = {
		parsers = { "regex" },
	},

	treesitter = {
		parsers = { "query" },
	},

	toml = {
		formatters = { toml = { "taplo" } },
		lsp_servers = { taplo = {} },
		packages = { "taplo" },
		parsers = { "toml" },
	},

	vim = {
		lsp_servers = { vimls = {} },
		packages = { "vim-language-server" },
		parsers = { "vim", "vimdoc" },
	},

	yaml = {
		formatters = { yaml = { "prettierd" } },
		lsp_servers = { yamlls = {} },
		packages = { "prettierd", "yaml-language-server" },
		parsers = { "yaml" },
	},
}

local M = {}

function M.formatters()
	local formatters = {}

	for _, tools in pairs(languages) do
		formatters = vim.tbl_extend("force", formatters, tools.formatters or {})
	end

	return formatters
end

function M.lsp_servers()
	local servers = {}

	for _, tools in pairs(languages) do
		servers = vim.tbl_extend("force", servers, tools.lsp_servers or {})
	end

	return servers
end

function M.packages()
	local packages = {}

	for _, tools in pairs(languages) do
		packages = vim.list_extend(packages, tools.packages or {})
	end

	return packages
end

function M.parsers()
	local parsers = {}

	for _, tools in pairs(languages) do
		parsers = vim.list_extend(parsers, tools.parsers or {})
	end

	return parsers
end

return M
