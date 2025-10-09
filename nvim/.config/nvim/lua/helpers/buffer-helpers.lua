local M = {}

--- Close current buffer but keep window layout by creating a new empty buffer when multiple windows exist.
---@return nil
M.close_buffer_keep_window = function()
	local current_buf = vim.api.nvim_get_current_buf()
	local window_count = #vim.api.nvim_list_wins()

	-- Only proceed if there are multiple windows (splits)
	if window_count > 1 then
		-- Create a new empty buffer
		vim.cmd("enew")
		-- Delete the previous buffer
		vim.api.nvim_buf_delete(current_buf, { force = false })
	else
		-- If only one window, just delete the buffer normally
		vim.cmd("bdelete")
	end
end

return M
