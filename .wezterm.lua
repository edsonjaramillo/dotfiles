local wezterm = require("wezterm") --- @type Wezterm

local config = wezterm.config_builder() --- @type Config

-- Appearance
config.enable_tab_bar = true

config.font = wezterm.font("GeistMono Nerd Font")
config.font_size = 13

config.cell_width = 1.0
config.tab_max_width = 25

config.colors = {
	background = "#0a0a0a",
	foreground = "#f5f5f5",
	ansi = {
		"#0a0a0a",
		"#ff6467",
		"#05df72",
		"#ffdf20",
		"#51a2ff",
		"#ed6aff",
		"#00b8db",
		"#f5f5f5",
	},
	brights = {
		"#262626",
		"#e7000b",
		"#00a63e",
		"#f0b100",
		"#155dfc",
		"#e12afb",
		"#0092b8",
		"#fafafa",
	},
}

-- config.window_decorations = "RESIZE"
local padding = 15
config.window_padding = {
	left = padding,
	right = padding,
	top = padding,
	bottom = padding - 10,
}
config.initial_cols = 120
config.initial_rows = 30

-- Performance
config.animation_fps = 60
config.max_fps = 120
config.cursor_blink_rate = 500

return config
