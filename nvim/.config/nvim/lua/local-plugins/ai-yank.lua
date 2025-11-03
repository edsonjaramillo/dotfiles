local notify = require("notify")
local M = {}

---Get bufnr from Copilot Chat if it exists
---@return number|nil
local function get_gitcommit_bufnr()
	local buf_list = vim.api.nvim_list_bufs()

	for _, bufnr in ipairs(buf_list) do
		if vim.api.nvim_buf_is_loaded(bufnr) then
			local buf_name = vim.api.nvim_buf_get_name(bufnr)
			local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

			if filetype == "gitcommit" then
				return bufnr
			end
		end
	end

	return nil
end

---@param commit_prompt string
M.commit = function(commit_prompt)
	local notifyTitle = "Copilot Commit Message"
	local record = notify("Generating commit message...", "info", {
		title = notifyTitle,
		timeout = false,
	})

	local copilot = require("CopilotChat")
	copilot.ask(commit_prompt, {
		model = "gpt-5-mini",
		sticky = { "#git:staged", "#gitdiff:staged" },
		callback = function(response)
			local commit_bufnr = get_gitcommit_bufnr()
			if not commit_bufnr then
				notify("Could not find gitcommit buffer.", "error", {
					replace = record,
					title = notifyTitle,
					timeout = 3000,
				})
				return
			end

			local commit_msg = vim.split(response.content, "\n")
			vim.api.nvim_buf_set_lines(commit_bufnr, 0, -1, false, commit_msg)
			notify("Commit message generated.", "info", {
				replace = record,
				title = notifyTitle,
				timeout = 3000,
			})
		end,
	})
	copilot.reset()
	copilot.close()
end

return M
