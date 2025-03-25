return {
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "*",
		event = { "InsertEnter", "CmdlineEnter" },

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = function()
			return {
				completion = {
					menu = {
						border = "rounded",
						auto_show = false,
					},
					documentation = { window = { border = "rounded" } },
					ghost_text = { enabled = false },
				},
				sources = {
					default = { "lazydev", "lsp", "path", "snippets", "buffer" },
					-- default = { "lazydev" },
					providers = {
						lazydev = {
							name = "LazyDev",
							module = "lazydev.integrations.blink",
							score_offset = 100, -- show at a higher priority than lsp
						},
					},
				},
				signature = { window = { border = "rounded" } },
			}
		end,
		config = function(_, opts)
			require("blink.cmp").setup(opts)
		end,
	},
	{
		"akinsho/bufferline.nvim",
		-- disable tabs
		enabled = false,
	},
	{
		"catppuccin/nvim",
		lazy = true,
		name = "catppuccin",
		opts = function()
			return {
				dim_inactive = { enabled = true },
				-- default_integrations = false,
				integrations = {
					blink_cmp = true,
					flash = true,
					grug_far = true,
					gitsigns = true,
					lsp_trouble = true,
					-- lualine enabled in lualine config
					mason = true,
					markdown = true,
					mini = true,
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
							ok = { "italic" },
						},
						underlines = {
							errors = { "underline" },
							hints = { "underline" },
							warnings = { "underline" },
							information = { "underline" },
							ok = { "underline" },
						},
						inlay_hints = {
							background = true,
						},
					},
					noice = true,
					snacks = true,
					treesitter = true,
					treesitter_context = true,
					which_key = true,
				},
			}
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				css = { "prettier" },
				go = { "goimports" },
				html = { "prettier" },
				javascript = { "prettier" },
				json = { "prettier" },
				jsonc = { "prettier" },
				markdown = { "prettier", "markdownlint-cli2", "markdown-toc" },
				ruby = { "rubocop" },
				rust = { "rustfmt" },
				toml = { "taplo" },
				typescript = { "prettier" },
				yaml = { "prettier" },
			},
		},
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
        -- stylua: ignore
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "catppuccin",
		},
	},
	{
		"nvim-lspconfig",
		opts = {
			servers = {
				gopls = {},
				marksman = {},
				ruby_lsp = {},
				rust_analyzer = {},
				taplo = {},
			},
			inlay_hints = { enabled = false },
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		init = function()
			vim.g.lualine_laststatus = vim.o.laststatus
			if vim.fn.argc(-1) > 0 then
				-- set an empty statusline till lualine loads
				vim.o.statusline = " "
			else
				-- hide the statusline on the starter page
				vim.o.laststatus = 0
			end
		end,
		opts = function()
			local icons = LazyVim.config.icons

			vim.o.laststatus = vim.g.lualine_laststatus

			return {
				options = {
					theme = "catppuccin",
					section_separators = "",
					component_separators = "",
					globalstatus = vim.o.laststatus == 3,
					disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
				},
				sections = {
					lualine_b = {
						"branch",
					},
					lualine_c = {
						{
							"filename",
							path = 1,
						},
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
						},
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
						},
					},
					lualine_x = {
						"encoding",
						{
							"fileformat",
							symbols = {
								unix = "unix",
								dos = "dos",
								mac = "mac",
							},
						},
						"filetype",
					},
				},
				extensions = { "neo-tree", "lazy", "fzf" },
			}
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"goimports",
				"markdownlint-cli2",
				"markdown-toc",
				"prettier",
				"rust-analyzer",
				"taplo",
			},
			ui = { border = "rounded" },
		},
	},
	{
		"folke/noice.nvim",
		opts = {
			cmdline = {
				view = "cmdline",
			},
			presets = {
				command_palette = false,
				lsp_doc_border = true,
			},
		},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {
			enabled = false,
			code = {
				sign = false,
				width = "block",
				right_pad = 1,
			},
			heading = {
				sign = false,
				icons = {},
			},
			checkbox = {
				enabled = false,
			},
		},
		ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
		config = function(_, opts)
			require("render-markdown").setup(opts)
			Snacks.toggle({
				name = "Render Markdown",
				get = function()
					return require("render-markdown.state").enabled
				end,
				set = function(enabled)
					local m = require("render-markdown")
					if enabled then
						m.enable()
					else
						m.disable()
					end
				end,
			}):map("<leader>um")
		end,
	},
	{
		"folke/snacks.nvim",
		opts = {
			-- indent = {
			-- 	-- disable indent guides
			-- 	enabled = false,
			-- },
			picker = {
				sources = {
					explorer = {
						-- display hidden files
						hidden = true,
					},
					files = {
						-- search hidden files
						hidden = true,
					},
					grep = {
						-- search hidden files
						hidden = true,
					},
				},
			},
		},
	},
	{
		"folke/tokyonight.nvim",
		enabled = false,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"git_config",
				"git_rebase",
				"gitattributes",
				"gitcommit",
				"gitignore",
				"go",
				"gomod",
				"gosum",
				"gowork",
				"make",
				"puppet",
				"ron",
				"ruby",
				"rust",
			},
		},
	},
}
