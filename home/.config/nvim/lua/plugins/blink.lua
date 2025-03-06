return {
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
}
