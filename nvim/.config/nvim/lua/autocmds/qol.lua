-- Close helper buffers with 'q' and keep them out of the buffer list
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"help",
		"man",
		"qf",
		"lspinfo",
		"checkhealth",
		"startuptime",
		"spectre_panel",
		"git",
		"netrw",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- Return to last cursor position when reopening filetypes
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- reload file if changed outside of nvim
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	command = "checktime",
})
