--
--[[ Options ]]
--

vim.g.mapleader = " " -- Set <Space> as <Leeader>
vim.g.maplocalleader = " " -- Set <Space> as <LocalLeader>

vim.opt.breakindent = true -- Wrapped line repeats indent
vim.opt.clipboard = "unnamedplus" -- Sync Neovim and OS clipboard
vim.opt.completeopt = "menu,menuone,noselect" -- Options for Insert mode completion
vim.opt.expandtab = true -- Use spaces when tab is inserted
vim.opt.hlsearch = false -- Highlight matches with last search pattern
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.number = true -- Print the line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.shiftwidth = 4 -- Number of spaces for autoindent
vim.opt.signcolumn = "yes" -- Always display the sign column
vim.opt.smartcase = true -- Do not ignore case when pattern has uppercase
vim.opt.splitbelow = true -- Split new window below current
vim.opt.splitright = true -- Split new window right of current
vim.opt.tabstop = 4 -- Number of spaces tab uses
vim.opt.termguicolors = true -- Enable 24-bit RGB color
vim.opt.wrap = false -- Long lines wrap to the next line

--
--[[ Keymaps ]]
--

-- Diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist)

-- Fuzzy finder
vim.keymap.set("n", "<Leader>fB", ":Telescope file_browser<CR>", { silent = true })
vim.keymap.set("n", "<Leader>fb", ":Telescope buffers<CR>", { silent = true })
vim.keymap.set("n", "<Leader>ff", ":Telescope find_files<CR>", { silent = true })
vim.keymap.set("n", "<Leader>fg", ":Telescope live_grep<CR>", { silent = true })
vim.keymap.set("n", "<Leader>fh", ":Telescope help_tags<CR>", { silent = true })
vim.keymap.set("n", "<Leader>fk", ":Telescope keymaps<CR>", { silent = true })
vim.keymap.set("n", "<Leader>fn", ":Telescope noice<CR>", { silent = true })

-- Language server
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }

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

-- Moving text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Plugin manager
vim.keymap.set("n", "<Leader>ll", ":Lazy<CR>", { silent = true })
vim.keymap.set("n", "<Leader>lp", ":Lazy profile<CR>", { silent = true })
vim.keymap.set("n", "<Leader>lu", ":Lazy update<CR>", { silent = true })

-- Scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Wrapping lines
vim.keymap.set("n", "<Leader>w", ":set wrap!<CR>", { silent = true })

--
--[[ Commands ]]
--

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

--
--[[ Language Settings ]]
--

local languages = {
	data_formats = {
		conform = {
			json = { "prettierd", "prettier" },
			toml = { "taplo" },
			yaml = { "prettierd", "prettier" },
		},
		lspconfig = { jsonls = {}, taplo = {}, yamlls = {} },
		mason = { "json-lsp", "prettierd", "taplo", "yaml-language-server" },
		treesitter = { "json", "toml", "yaml" },
	},

	git = {
		conform = {},
		lspconfig = {},
		mason = {},
		treesitter = { "git_config", "gitcommit", "gitignore" },
	},

	go = {
		conform = { go = { "goimports", "gofmt" } },
		lspconfig = { gopls = {} },
		mason = { "gopls" },
		treesitter = { "go" },
	},

	html_css = {
		conform = {
			css = { "prettierd", "prettier" },
			html = { "prettierd", "prettier" },
		},
		lspconfig = { cssls = {}, html = {} },
		mason = { "css-lsp", "html-lsp", "prettierd" },
		treesitter = { "css", "html" },
	},

	javascript = {
		conform = {
			javascript = { "prettierd", "prettier" },
			typescript = { "prettierd", "prettier" },
		},
		lspconfig = {
			tsserver = {
				settings = {
					completions = {
						completeFunctionCalls = true,
					},
				},
			},
		},
		mason = { "prettierd", "typescript-language-server" },
		treesitter = { "javascript", "jsdoc", "typescript" },
	},

	lua = {
		conform = { lua = { "stylua" } },
		lspconfig = {
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
		mason = { "lua-language-server", "stylua" },
		treesitter = { "lua", "luadoc" },
	},

	markdown = {
		conform = { markdown = { "prettierd", "prettier" } },
		lspconfig = { marksman = {} },
		mason = { "marksman", "prettierd" },
		treesitter = { "markdown", "markdown_inline" },
	},

	misc = {
		conform = {},
		lspconfig = {},
		mason = {},
		treesitter = { "c", "query", "regex" },
	},

	python = {
		conform = { python = { "ruff_formatt" } },
		lspconfig = {
			pyright = {},
			ruff_lsp = {
				on_attach = function(client, _)
					client.server_capabilities.hoverProvider = false
				end,
			},
		},
		mason = { "pyright", "ruff", "ruff-lsp" },
		treesitter = { "python" },
	},

	shell = {
		conform = { fish = { "fish_indent" }, sh = { "shfmt" } },
		lspconfig = { bashls = {} },
		mason = { "bash-language-server", "shfmt" },
		treesitter = { "bash", "fish" },
	},

	vim = {
		conform = {},
		lspconfig = { vimls = {} },
		mason = { "vim-language-server" },
		treesitter = { "vim", "vimdoc" },
	},
}

local function language_settings(plugin)
	local merged = {}
	for _, settings in pairs(languages) do
		if "conform" == plugin or "lspconfig" == plugin then
			merged = vim.tbl_extend("force", merged, settings[plugin])
		else
			merged = vim.list_extend(merged, settings[plugin])
		end
	end
	return merged
end

--
--[[ Plugins ]]
--

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Colorscheme
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				integrations = {
					lsp_trouble = true,
					mason = true,
					noice = true,
					notify = true,
					treesitter_context = true,
				},
			})

			vim.cmd.colorscheme("catppuccin")
		end,
	},

	-- Code commenting
	{
		"numToStr/Comment.nvim",
		opts = {},
	},

	-- Formatting
	{
		"stevearc/conform.nvim",
		dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
		opts = {
			format_on_save = {
				timeout_ms = 500,
			},
			formatters_by_ft = language_settings("conform"),
		},
	},

	-- Git decorations
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},

	-- Indentation guides
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			scope = { enabled = false },
		},
	},

	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				icons_enabled = false,
				theme = "catppuccin",
				component_separators = "",
				section_separators = "",
			},
		},
	},

	-- Language servers, linters, and formatters
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		opts = { ui = { border = "rounded" } },
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		build = ":MasonToolsUpdate",
		opts = {
			ensure_installed = language_settings("mason"),
		},
	},

	-- Command line and notifications
	{
		"folke/noice.nvim",
		dependencies = {
			{ "MunifTanjim/nui.nvim" },
			{ "rcarriga/nvim-notify" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		opts = {
			cmdline = { view = "cmdline" },
			lsp = {
				progress = { enabled = false },
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				-- bottom_search = true,
				-- command_palette = true,
				lsp_doc_border = true,
			},
		},
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "windwp/nvim-autopairs", opts = {} },

			-- Sources
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-cmdline" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-path" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "buffer" },
					{ name = "cmdline" },
					{ name = "luasnip" },
					{ name = "nvim_lsp" },
					{ name = "path" },
				}, {
					{ name = "buffer" },
				}),
			})

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})

			require("luasnip.loaders.from_vscode").lazy_load()

			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	-- Language server
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
			{ "folke/neodev.nvim", opts = {} },
			{ "hrsh7th/nvim-cmp" },
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			for server, server_opts in pairs(language_settings("lspconfig")) do
				server_opts.capabilities = capabilities

				require("lspconfig")[server].setup(server_opts)
			end

			require("lspconfig.ui.windows").default_options.border = "rounded"
		end,
	},

	-- Code parsing, highlighting, and navigation
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
			{ "nvim-treesitter/nvim-treesitter-textobjects" },
		},
		build = ":TSUpdate",
		opts = {
			ensure_installed = language_settings("treesitter"),
			highlight = { enabled = true },
			indent = { enable = true },

			textobjects = {
				move = {
					enable = true,
					goto_next = {
						["]a"] = "@parameter.inner",
						["]b"] = "@block.outer",
						["]c"] = "@class.outer",
						["]f"] = "@function.outer",
						["]i"] = "@conditional.outer",
						["]l"] = "@loop.outer",
					},
					goto_previous = {
						["[a"] = "@parameter.inner",
						["[b"] = "@block.outer",
						["[c"] = "@class.outer",
						["[f"] = "@function.outer",
						["[i"] = "@conditional.outer",
						["[l"] = "@loop.outer",
					},
				},
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["ab"] = "@block.outer",
						["ib"] = "@block.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ai"] = "@conditional.outer",
						["ii"] = "@conditional.inner",
						["al"] = "@loop.outer",
						["il"] = "@loop.inner",
					},
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	-- Fuzzy finder and file browser
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			{ "folke/noice.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-file-browser.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		opts = {
			defaults = {
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
				wrap_results = true,
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			telescope.load_extension("file_browser")
			telescope.load_extension("fzf")
			telescope.load_extension("noice")
		end,
	},

	-- Diagnostics
	{
		"folke/trouble.nvim",
		opts = {
			icons = false,
			use_diagnostic_signs = true,
		},
		init = function()
			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
				},
				float = { border = "rounded" },
				severity_sort = true,
			})
		end,
	},
}, {
	install = { colorscheme = { "catppuccin" } },
	ui = { border = "rounded" },
})
