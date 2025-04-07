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
				zig = { "zigfmt" },
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
				zls = {},
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
							path = 3,
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
				"zls",
			},
			ui = { border = "rounded" },
		},
	},
	{
		"echasnovski/mini.ai",
		event = "VeryLazy",
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({ -- code block
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
					t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
					d = { "%f[%d]%d+" }, -- digits
					e = { -- Word with case
						{
							"%u[%l%d]+%f[^%l%d]",
							"%f[%S][%l%d]+%f[^%l%d]",
							"%f[%P][%l%d]+%f[^%l%d]",
							"^[%l%d]+%f[^%l%d]",
						},
						"^().*()$",
					},
					g = LazyVim.mini.ai_buffer, -- buffer
					u = ai.gen_spec.function_call(), -- u for "Usage"
					U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
				},
			}
		end,
		config = function(_, opts)
			require("mini.ai").setup(opts)
			LazyVim.on_load("which-key.nvim", function()
				vim.schedule(function()
					LazyVim.mini.ai_whichkey(opts)
				end)
			end)
		end,
	},
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		opts = {
			modes = { insert = true, command = true, terminal = false },
			-- skip autopair when next character is one of these
			skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
			-- skip autopair when the cursor is inside these treesitter nodes
			skip_ts = { "string" },
			-- skip autopair when next character is closing pair
			-- and there are more closing pairs than opening pairs
			skip_unbalanced = true,
			-- better deal with markdown code blocks
			markdown = true,
		},
		config = function(_, opts)
			LazyVim.mini.pairs(opts)
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = function()
			return {
				cmdline = {
					view = "cmdline",
				},
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				routes = {
					{
						filter = {
							event = "msg_show",
							any = {
								{ find = "%d+L, %d+B" },
								{ find = "; after #%d+" },
								{ find = "; before #%d+" },
							},
						},
						view = "mini",
					},
				},
				presets = {
					bottom_search = true,
					command_palette = false,
					long_message_to_split = true,
					lsp_doc_border = true,
				},
			}
		end,
        -- stylua: ignore
        keys = {
            { "<leader>sn", "", desc = "+noice"},
            { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
            { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
            { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
            { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
            { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
            { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
            { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
            { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
        },
		config = function(_, opts)
			-- HACK: noice shows messages from before it was enabled,
			-- but this is not ideal when Lazy is installing plugins,
			-- so clear the messages in this case.
			if vim.o.filetype == "lazy" then
				vim.cmd([[messages clear]])
			end
			require("noice").setup(opts)
		end,
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
				"zig",
			},
		},
	},
}
