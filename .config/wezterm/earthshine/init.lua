-- Main entry point for the plugin
package.path = os.getenv("HOME") .. "/.config/wezterm/earthshine-wezterm/colors/init.lua;" .. package.path

local M = {}

-- Import our color scheme
local colors = require('colors')

-- Function to apply our color scheme
function M.apply_colors(config)
    -- Merge our colors with the config
    config.colors = colors
    return config
end

-- Initialize function that will be called by WezTerm
function M.init(config)
    return M.apply_colors(config)
end

return M