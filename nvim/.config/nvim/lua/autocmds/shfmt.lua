local fmt = require("custom.formatter")

-- Auto-format sh/bash files with shfmt on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.sh", "*.bash" },
	callback = function()
		local filetype = fmt.get_filetype()
		if not fmt.check_filetype(filetype, { "sh", "bash" }) then
			return
		end

		if not fmt.check_executable("shfmt") then
			return
		end

		local lines = fmt.get_buffer_lines()
		local input = table.concat(lines, "\n")

		local argv = { "shfmt", "-filename", "stdin", "-" }

		local bufnr = fmt.get_bufnr()
		fmt.command("shfmt", bufnr, argv, input)
	end,
})
