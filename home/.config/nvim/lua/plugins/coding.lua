return {
	"saghen/blink.cmp",
	opts = {
		keymap = require("blink.cmp.config").keymap,
		completion = {
			menu = { border = "rounded" },
			documentation = { window = { border = "rounded" } },
			ghost_text = {
				enabled = false,
			},
		},
		cmdline = require("blink.cmp.config.modes.cmdline").default,
		signature = { window = { border = "rounded" } },
	},
}
