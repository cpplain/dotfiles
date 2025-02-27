return {
	"williamboman/mason.nvim",
	-- cmd = "Mason",
	build = ":MasonUpdate",
	opts = {
		ensure_installed = {
			"bash-language-server",
			"clang-format",
			"clangd",
			"css-lsp",
			"goimports",
			"gopls",
			"html-lsp",
			"json-lsp",
			"lua-language-server",
			"marksman",
			"prettierd",
			"pyright",
			"ruff",
			"rubocop",
			"shfmt",
			"stylua",
			"taplo",
			"typescript-language-server",
			"vim-language-server",
			"yaml-language-server",
		},
		ui = {
			border = "rounded",
		},
	},
	config = function(_, opts)
		require("mason").setup(opts)

		local registry = require("mason-registry")

		registry.refresh(function()
			for _, name in ipairs(opts.ensure_installed) do
				local pkg = registry.get_package(name)
				if not pkg:is_installed() then
					pkg:install()
				end
			end
		end)
	end,
}
