--
--[[ Formatting ]]
--

return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			format_on_save = {
				timeout_ms = 500,
			},
			formatters_by_ft = require("config.lang_tools").formatters(),
		})
	end,
}
