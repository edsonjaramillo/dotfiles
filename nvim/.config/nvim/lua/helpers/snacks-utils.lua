local M = {}

-- Directory names to exclude from searches/file pickers.
M.folder_exclude = { "node_modules", ".git", "dist" }

-- A set containing the current working directory. Used to "prioritize" the cwd in
-- other parts of the configuration (e.g., sorter hints). The key name keeps the
-- original typo for backwards compatibility.
M.priotize_cwd = { [vim.fn.getcwd()] = true }

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
