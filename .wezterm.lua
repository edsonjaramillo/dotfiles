local wezterm = require 'wezterm'

local config = wezterm.config_builder()

local earthshine = require 'earthshine-wezterm'
config = earthshine.init(config)

-- Font
-- Brew install: brew install --cask font-geist-mono-nerd-font (Recommended)
-- or manual https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/GeistMono.zip'
config.font = wezterm.font('GeistMono Nerd Font')
config.font_size = 12

-- General
config.enable_tab_bar = false

-- Background
config.background = {
    {
        source = {
            File = wezterm.home_dir .. "/.config/wezterm/wallpapers/151.jpg",
        },
        width = "Contain",
        height = "Contain",
        opacity = 1,
        hsb = {
            hue = 1.0,
            saturation = 1.0,
            brightness = 0.0078125,
        },
        attachment = { Parallax = 0.2 },
    }
}
-- config.window_background_opacity = 0.3
config.macos_window_background_blur = 40
config.inactive_pane_hsb = {
    brightness = 0.33,
}

-- Cursor
config.default_cursor_style = 'BlinkingBlock'

-- Padding
local padding = 20
config.window_padding = {
    left = padding,
    right = padding,
    top = padding,
    bottom = padding,
}

return config
