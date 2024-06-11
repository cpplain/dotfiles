return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				-- "bash",
				-- "c",
				-- "css",
				-- "fish",
				-- "git_config",
				-- "gitcommit",
				-- "gitignore",
				-- "go",
				-- "gomod",
				-- "gosum",
				-- "gowork",
				-- "html",
				-- "javascript",
				-- "jsdoc",
				-- "json",
				-- "lua",
				-- "luadoc",
				-- "make",
				-- "markdown",
				-- "markdown_inline",
				-- "python",
				-- "query",
				-- "regex",
				-- "toml",
				-- "typescript",
				-- "vim",
				-- "vimdoc",
				-- "yaml",
			},

			sync_install = false,
			-- auto_install = false,
			auto_install = true,
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
}
