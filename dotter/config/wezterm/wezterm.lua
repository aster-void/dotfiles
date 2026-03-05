local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Frappe"
config.window_close_confirmation = "NeverPrompt"

return config
