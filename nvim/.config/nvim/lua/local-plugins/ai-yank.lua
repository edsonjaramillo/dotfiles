local notify = require("notify")
local M = {}

---Get bufnr from Copilot Chat if it exists
---@return number|nil
local function get_copilot_chat_bufnr()
	local buf_list = vim.api.nvim_list_bufs()

	for _, bufnr in ipairs(buf_list) do
		if vim.api.nvim_buf_is_loaded(bufnr) then
			local buf_name = vim.api.nvim_buf_get_name(bufnr)
			local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

			if filetype == "copilot-chat" or buf_name:match("Copilot Chat") then
				return bufnr
			end
		end
	end

	return nil
end

--- Yank commit message from Copilot Chat buffer to system clipboard
--- @param record_id number
--- @param notify_title string
M.yank_commit_message = function(record_id, notify_title)
	local copilot_chat_bufnr = get_copilot_chat_bufnr()
	if not copilot_chat_bufnr then
		notify.notify("No Copilot Chat buffer found", "ERROR", {
			replace = record_id,
			title = notify_title,
			timeout = 1000,
		})
		return nil
	end

	local lines = vim.api.nvim_buf_get_lines(copilot_chat_bufnr, 0, -1, false)

	local recording = false
	local commit_message_lines = {}

	for _, line in ipairs(lines) do
		-- start recording after a Copilot header
		if line:match("^#%s+Copilot") then
			recording = true
			goto continue
		end

		-- stop when next User header appears
		if recording and line:match("^#%s+User %(.+%) ───") then
			break
		end

		if recording then
			if line ~= "" then
				table.insert(commit_message_lines, line)
			end
		end

		::continue::
	end

	local formatted_message = table.concat(commit_message_lines, "\n")

	vim.fn.setreg("+", formatted_message)
	notify.notify("Commit message yanked to system clipboard", "INFO", {
		replace = record_id,
		title = notify_title,
		timeout = 1000,
	})

	return formatted_message
end

return M
