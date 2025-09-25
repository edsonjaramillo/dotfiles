local notify = require("notify")

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.lua",
	callback = function()
		local filetype = vim.bo.filetype
		if filetype ~= "lua" then
			notify("Not a lua file; skipping formatting", "warn", { title = "stylua" })
			return
		end
		-- stylua not installed; skipping
		if vim.fn.executable("stylua") == 0 then
			notify("stylua not found in PATH; skipping formatting", "warn", { title = "stylua" })
			return
		end

		local output = vim.fn.system("stylua -", vim.api.nvim_buf_get_lines(0, 0, -1, false))
		local exit_code = vim.v.shell_error

		if exit_code ~= 0 then
			notify(
				"stylua failed with exit code " .. exit_code .. ": " .. output,
				"error",
				{ title = "stylua" }
			)
			return
		end

		-- Replace buffer content with formatted output
		local formatted_lines = vim.split(output, "\n", { trimempty = false })
		vim.api.nvim_buf_set_lines(0, 0, -1, false, formatted_lines)
	end,
})

