return {
	{
		"saghen/blink.cmp",
		opts = {
			keymap = require("blink.cmp.config.keymap").default,
			completion = {
				menu = {
					border = "rounded",
					auto_show = false,
				},
				documentation = { window = { border = "rounded" } },
				ghost_text = { enabled = false },
			},
			signature = { window = { border = "rounded" } },
			cmdline = require("blink.cmp.config.modes.cmdline").default,
		},
	},
	{
		"akinsho/bufferline.nvim",
		-- disable tabs
		enabled = false,
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
			indent = {
				-- disable indent guides
				enabled = false,
			},
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
