local stylua = require("abide").Abide:new("stylua")

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.lua" },
	callback = function()
		local filetype = stylua:get_filetype()
		if not stylua:check_filetypes(filetype, { "lua" }) then
			return
		end

		if not stylua:check_executable() then
			return
		end

		local lines = stylua:get_buffer_lines()
		local input = table.concat(lines, "\n")

		local argv = { "stylua", "-" }

		local bufnr = stylua:get_bufnr()
		stylua:command(bufnr, argv, input)
	end,
})
