local M = {}

-- Enable showing hidden files in the 'oil' file browser.
-- Requires the 'oil' plugin to be installed and in Lua's package path.
--- @return nil
M.enable_hidden = function()
	local oil = require("oil")
	oil.setup({ view_options = { show_hidden = true } })
end

-- Disable showing hidden files in the 'oil' file browser.
--- @return nil
M.disable_hidden = function()
	local oil = require("oil")
	oil.setup({ view_options = { show_hidden = false } })
end

return M
