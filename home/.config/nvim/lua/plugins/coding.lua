return {
	"saghen/blink.cmp",
	opts = {
		keymap = require("blink.cmp.config").keymap,
		completion = {
			menu = { border = "rounded" },
			documentation = { window = { border = "rounded" } },
		},
		sources = {
			cmdline = require("blink.cmp.config.sources").default.cmdline,
		},
		signature = { window = { border = "rounded" } },
	},
}
