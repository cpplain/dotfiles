local wezterm = require("wezterm")

local config = {}

--[[ Default Config ]]

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

--[[ User Config ]]

-- Change default shell
if wezterm.target_triple == "aarch64-apple-darwin" then
	config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
elseif wezterm.target_triple == "x86_64-apple-darwin" then
	config.default_prog = { "/usr/local/bin/fish", "-l" }
end

config.color_scheme = "Catppuccin Mocha"
config.enable_tab_bar = false
config.font = wezterm.font("SF Mono")
config.font_size = 12
-- config.macos_window_background_blur = 100
-- config.window_background_opacity = 0.9
-- config.window_decorations = "RESIZE"

return config
