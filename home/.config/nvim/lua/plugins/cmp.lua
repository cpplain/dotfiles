return {
	"hrsh7th/nvim-cmp",
	enabled = false,
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
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
			mapping = {
				["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
				["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
				["<C-y>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), { "i", "c" }),
				["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
				["<C-e>"] = cmp.mapping(cmp.mapping.abort(), { "i", "c" }),
			},
			sources = cmp.config.sources({
				-- group 1
				{ name = "lazydev" },
			}, {
				-- group 2
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
				--group 3
				{ name = "buffer" },
			}),
		})

		cmp.setup.cmdline({ "/", "?" }, {
			sources = {
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline(":", {
			sources = cmp.config.sources({
				-- group 1
				{ name = "path" },
			}, {
				-- group 2
				{ name = "cmdline" },
			}),
		})
	end,
}
