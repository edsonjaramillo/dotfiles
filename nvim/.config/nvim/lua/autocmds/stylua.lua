local fmt = require("custom.formatter")

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.lua" },
	callback = function()
		local filetype = fmt.get_filetype()
		if not fmt.check_filetype(filetype, { "lua" }) then
			return
		end

		if not fmt.check_executable("stylua") then
			return
		end

		local lines = fmt.get_buffer_lines()
		local input = table.concat(lines, "\n")

		local argv = { "stylua", "-" }

		local bufnr = fmt.get_bufnr()
		fmt.command("stylua", bufnr, argv, input)
	end,
})
