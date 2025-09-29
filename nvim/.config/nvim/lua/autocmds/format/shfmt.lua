local shfmt = require("abide").Abide:new("shfmt")

-- Auto-format sh/bash files with shfmt on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.sh", "*.bash" },
	callback = function()
		local filetype = shfmt:get_filetype()
		if not shfmt:check_filetypes(filetype, { "sh", "bash" }) then
			return
		end

		if not shfmt:check_executable() then
			return
		end

		local lines = shfmt:get_buffer_lines()
		local input = table.concat(lines, "\n")

		local argv = { "shfmt", "-filename", "stdin", "-" }

		local bufnr = shfmt:get_bufnr()
		shfmt:command(bufnr, argv, input)
	end,
})
