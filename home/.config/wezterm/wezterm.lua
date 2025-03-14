local wezterm = require("wezterm")
local mux = wezterm.mux
local config = {}

--
-- Default Config
--

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

--
-- User Config
--

-- Change default shell
config.default_prog = { "/opt/homebrew/bin/fish", "-l" }

config.color_scheme = "Catppuccin Mocha"
config.enable_tab_bar = false
config.font = wezterm.font("SF Mono")
config.font_size = 12
-- config.window_decorations = "RESIZE"
-- config.window_padding = {
-- 	left = 20,
-- 	right = 20,
-- 	top = 20,
-- 	bottom = 20,
-- }

wezterm.on("gui-startup", function(cmd)
	local _, _, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

return config
