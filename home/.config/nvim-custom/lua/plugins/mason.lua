local packages = {
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
}

return {
	"williamboman/mason.nvim",
	lazy = true,
	cmd = "Mason",
	config = function()
		require("mason").setup({
			ui = {
				border = "rounded",
			},
		})

		local registry = require("mason-registry")

		registry.refresh(function()
			for _, pkg_name in ipairs(packages) do
				local pkg = registry.get_package(pkg_name)
				if not pkg:is_installed() then
					pkg:install()
				end
			end
		end)
	end,
}
