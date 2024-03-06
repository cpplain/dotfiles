-- Use default config if running in VS Code
if vim.g.vscode then
	print("Neovim running in VS Code. Using default config.")
	return
end

--
--[[ Options ]]
--

-- Leader
vim.g.mapleader = " " -- Set <Space> as <Leader>
vim.g.maplocalleader = " " -- Set <Space> as <LocalLeader>

-- Indentation and wrapping
vim.opt.breakindent = true -- Wrapped line repeats indent
vim.opt.expandtab = true -- Use spaces when tab is inserted
vim.opt.linebreak = true -- Wrap lines are word boundary
vim.opt.shiftwidth = 4 -- Number of spaces for autoindent
vim.opt.tabstop = 4 -- Number of spaces tab uses
vim.opt.wrap = false -- Long lines wrap to the next line

-- OS integration
vim.opt.clipboard = "unnamedplus" -- Sync Neovim and OS clipboard

-- Search
vim.opt.hlsearch = false -- Highlight matches with last search pattern
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true -- Do not ignore case when pattern has uppercase

-- Spelling
vim.opt.spell = true
vim.opt.spelllang = "en_us"

-- UI
vim.opt.completeopt = "menu,menuone,noselect" -- Options for Insert mode completion
vim.opt.number = true -- Print the line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.signcolumn = "yes" -- Always display the sign column
vim.opt.splitbelow = true -- Split new window below current
vim.opt.splitright = true -- Split new window right of current
vim.opt.termguicolors = true -- Enable 24-bit RGB color

--
--[[ Keymaps ]]
--

-- Diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist)

-- LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help)
vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename)

-- Markdown preview
vim.keymap.set({ "n", "i" }, "<Leader>mp", "<Cmd>MarkdownPreviewToggle<CR>")

-- Moving text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Wrapping lines
vim.keymap.set("n", "<Leader>w", "<Cmd>set wrap!<CR>")

--
--[[ Commands ]]
--

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	group = vim.api.nvim_create_augroup("EnableWrap", { clear = true }),
	callback = function()
		vim.opt.wrap = true
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

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

	-- Code comments
	{
		"numToStr/Comment.nvim",
		config = true,
	},

	-- Formatting
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				format_on_save = {
					timeout_ms = 500,
				},
				formatters_by_ft = {
					css = { "prettierd" },
					fish = { "fish_indent" },
					go = { "goimports", "gofmt" },
					html = { "prettierd" },
					javascript = { "prettierd" },
					json = { "prettierd" },
					lua = { "stylua" },
					markdown = { "prettierd" },
					python = { "ruff_format" },
					sh = { "shfmt" },
					toml = { "taplo" },
					typescript = { "prettierd" },
					yaml = { "prettierd" },
				},
			})
		end,
	},

	-- Git decorations
	{
		"lewis6991/gitsigns.nvim",
		config = true,
	},

	-- Indentation guides
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("ibl").setup({
				scope = {
					enabled = false,
				},
			})
		end,
	},

	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()

			vim.keymap.set({ "i", "s" }, "<Tab>", "<Cmd>lua require('luasnip').jump(1)<CR>")
			vim.keymap.set({ "i", "s" }, "<S-Tab>", "<Cmd>lua require('luasnip').jump(-1)<CR>")
		end,
	},

	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = false,
					theme = "catppuccin",
					component_separators = "",
					section_separators = "",
				},
			})
		end,
	},

	-- Markdown preview
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	-- Server, linter, and formatter package manager
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

	-- Command line and notifications
	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("noice").setup({
				cmdline = {
					view = "cmdline",
				},
				lsp = {
					progress = {
						enabled = false,
					},
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
			})
		end,
	},

	-- Autopair completion
	{
		"windwp/nvim-autopairs",
		dependencies = { "hrsh7th/nvim-cmp" },
		config = function()
			require("nvim-autopairs").setup()

			local cmp = require("cmp")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- Sources
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			-- Snippets
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
                completion = {
                    autocomplete = false,
                },
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert(),
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
		end,
	},

	-- Linting
	{
		"mfussenegger/nvim-lint",
		config = function()
			require("lint").linters_by_ft = {
				fish = { "fish" },
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
			}

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
				group = vim.api.nvim_create_augroup("Lint", { clear = true }),
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},

	-- Language server configuration
	{
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
	},

	-- Parsing, highlighting, and navigation
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"c",
					"css",
					"fish",
					"git_config",
					"gitcommit",
					"gitignore",
					"go",
					"gomod",
					"gosum",
					"gowork",
					"html",
					"javascript",
					"jsdoc",
					"json",
					"lua",
					"luadoc",
					"markdown",
					"markdown_inline",
					"python",
					"query",
					"regex",
					"toml",
					"typescript",
					"vim",
					"vimdoc",
					"yaml",
				},

				sync_install = false,
				auto_install = false,
				ignore_install = {},

				modules = {},
				highlight = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<Tab>",
						node_incremental = "<Tab>",
						scope_incremental = false,
						node_decremental = "<BS>",
					},
				},
				indent = {
					enable = true,
				},

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
					swap = {
						enable = true,
						swap_next = {
							["<leader>a"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>A"] = "@parameter.inner",
						},
					},
				},
			})
		end,
	},

	-- Fuzzy finder and file browser
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"folke/noice.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					layout_config = {
						prompt_position = "top",
					},
					sorting_strategy = "ascending",
					wrap_results = true,
				},
			})
			telescope.load_extension("file_browser")
			telescope.load_extension("fzf")
			telescope.load_extension("noice")

			vim.keymap.set("n", "<Leader>fB", "<Cmd>Telescope file_browser<CR>")
			vim.keymap.set("n", "<Leader>fb", "<Cmd>Telescope buffers<CR>")
			vim.keymap.set("n", "<Leader>ff", "<Cmd>Telescope find_files<CR>")
			vim.keymap.set("n", "<Leader>ht", "<Cmd>Telescope help_tags<CR>")
			vim.keymap.set("n", "<Leader>km", "<Cmd>Telescope keymaps<CR>")
			vim.keymap.set("n", "<Leader>lg", "<Cmd>Telescope live_grep<CR>")
			vim.keymap.set("n", "<Leader>tn", "<Cmd>Telescope noice<CR>")
		end,
	},

	-- Sorter
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},

	-- Diagnostics
	{
		"folke/trouble.nvim",
		config = function()
			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
				},
				float = {
					border = "rounded",
				},
				severity_sort = true,
			})

			require("trouble").setup({
				icons = false,
				use_diagnostic_signs = true,
			})
		end,
	},
}, {
	install = { colorscheme = { "catppuccin" } },
	ui = { border = "rounded" },
	checker = { enabled = true },
})
