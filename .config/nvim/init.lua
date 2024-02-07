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

vim.g.mapleader = " " -- Set <Space> as <Leeader>
vim.g.maplocalleader = " " -- Set <Space> as <LocalLeader>

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
		opts = {
			format_on_save = {
				timeout_ms = 500,
			},
			formatters_by_ft = {
				css = { "prettierd", "prettier" },
				fish = { "fish_indent" },
				html = { "prettierd", "prettier" },
				javascript = { "prettierd", "prettier" },
				json = { "prettierd", "prettier" },
				go = { "goimports", "gofmt" },
				lua = { "stylua" },
				markdown = { "prettierd", "prettier" },
				python = { "ruff_formatt" },
				sh = { "shfmt" },
				typescript = { "prettierd", "prettier" },
				yaml = { "prettierd", "prettier" },
			},
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
			{ "folke/neodev.nvim", opts = {} },
			{ "hrsh7th/nvim-cmp" },
		},
		config = function()
			local servers = {
				bashls = {},
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
				pyright = {},
				ruff_lsp = {
					on_attach = function(client, _)
						client.server_capabilities.hoverProvider = false
					end,
				},
				tsserver = {
					settings = {
						completions = {
							completeFunctionCalls = true,
						},
					},
				},
				yamlls = {},
			}

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			for server, server_opts in pairs(servers) do
				server_opts.capabilities = capabilities

				require("lspconfig")[server].setup(server_opts)
			end
		end,
	},

	-- Code parsing, highlighting, and navigation
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"fish",
				"git_config",
				"gitcommit",
				"gitignore",
				"go",
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

--
--[[ Options ]]
--

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
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic message" })
vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Fuzzy finder
vim.keymap.set("n", "<Leader>fB", ":Telescope file_browser<CR>", { desc = "Telescope file browser" })
vim.keymap.set("n", "<Leader>fb", ":Telescope buffers<CR>", { desc = "Telescope find buffers" })
vim.keymap.set("n", "<Leader>ff", ":Telescope find_files<CR>", { desc = "Telescope find files" })
vim.keymap.set("n", "<Leader>fg", ":Telescope live_grep<CR>", { desc = "Telescope live grep" })
vim.keymap.set("n", "<Leader>fh", ":Telescope help_tags<CR>", { desc = "Telescope find help tags" })
vim.keymap.set("n", "<Leader>fk", ":Telescope keymaps<CR>", { desc = "Telescope keymaps" })
vim.keymap.set("n", "<Leader>fn", ":Telescope noice<CR>", { desc = "Telescope noice" })

-- Language server
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local function keymap(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
		end

		keymap("n", "gd", vim.lsp.buf.definition, "Goto definition")
		keymap("n", "gi", vim.lsp.buf.implementation, "Goto implementation")
		keymap("n", "gr", vim.lsp.buf.references, "Goto references")
		keymap("n", "gt", vim.lsp.buf.type_definition, "Goto type definition")
		keymap("n", "K", vim.lsp.buf.hover, "Hover information")
		keymap("i", "<C-k>", vim.lsp.buf.signature_help, "Signature information")
		keymap({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, "Code action")
		keymap("n", "<Leader>rn", vim.lsp.buf.rename, "Rename symbol")
	end,
})

-- Moving text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down and reindent" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up and reindent" })

-- Plugin manager
vim.keymap.set("n", "<Leader>ll", ":Lazy<CR>", { desc = "Open plugin manager" })
vim.keymap.set("n", "<Leader>lp", ":Lazy profile<CR>", { desc = "Run startup profile" })
vim.keymap.set("n", "<Leader>lu", ":Lazy update<CR>", { desc = "Update plugins" })

-- Scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Wrapping lines
vim.keymap.set("n", "<Leader>w", ":set wrap!<CR>", { desc = "Toggle line wrap" })

--
--[[ Commands ]]
--

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
