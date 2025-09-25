local notify = require("notify")

local M = {}

-- Notify with info level
-- @param topic string A topic for logging or identification (not used in this function)
-- @param msg string The message to notify
M.warn = function(topic, msg)
	notify(msg, "warn", { title = "Formatter (" .. topic .. ")" })
end

-- Notify with error level
-- @param topic string A topic for logging or identification (not used in this function)
-- @param msg string The message to notify
M.error = function(topic, msg)
	notify(msg, "error", { title = "Formatter (" .. topic .. ")" })
end

-- Notify with info level
-- @param topic string A topic for logging or identification (not used in this function)
-- @param msg string The message to notify
M.info = function(topic, msg)
	notify(msg, "info", { title = "Formatter (" .. topic .. ")" })
end

-- Notify with success level
-- @param topic string A topic for logging or identification (not used in this function)
-- @param msg string The message to notify
M.success = function(topic, msg)
	notify(msg, "success", { title = "Formatter (" .. topic .. ")" })
end

-- Get the current buffer's filetype
-- @return string The filetype of the current buffer
M.get_filetype = function()
	return vim.bo.filetype
end

-- Check if the current filetype is in the list of valid valid_types
-- @param ft string The current filetype
-- @param valid_types table A list of valid filetypes
-- @return boolean True if the filetype is valid, false otherwise
M.check_filetype = function(ft, valid_types)
	for _, v in ipairs(valid_types) do
		if ft == v then
			return true
		end
	end
	M.warn("Filetype " .. ft .. " not supported; skipping formatting")
	return false
end

-- Check if an executable is available in PATH
-- @param exe string The name of the executable to check
-- @return boolean True if the executable is found, false otherwise
M.check_executable = function(exe)
	if vim.fn.executable(exe) == 0 then
		M.warn(exe .. " not found in PATH; skipping formatting")
		return false
	end
	return true
end

-- Get all lines from the given bufnr or the current buffer if bufnr is 0 or nil
-- @return table A list of lines from buffer
M.get_buffer_lines = function(bufnr)
	bufnr = bufnr or 0
	return vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
end

-- Get the current buffer number
-- @return number The current buffer number
M.get_bufnr = function()
	return vim.api.nvim_get_current_buf()
end

-- Run a command with optional input and return the result
-- @param topic string A topic for logging or identification (not used in this function)
-- @param bufnr number The buffer number (not used in this function)
-- @param cmd table A list representing the command and its arguments
-- @param input string Input to be passed to the command's stdin
M.command = function(topic, bufnr, cmd, input)
	if not vim.api.nvim_buf_is_valid(bufnr) then
		M.error(topic, "Buffer " .. bufnr .. " is no longer valid; skipping formatting")
		return
	end

	local result = vim.system(cmd, { stdin = input, text = true }):wait()

	if result.code ~= 0 then
		M.error(topic, "Command failed with exit code " .. result.code .. ": " .. (result.stderr or ""))
		return
	end

	local formatted_lines = vim.split(result.stdout, "\n", { trimempty = false })

	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, formatted_lines)
	M.success(topic, "Formatted buffer " .. bufnr .. " successfully")
end

return M

