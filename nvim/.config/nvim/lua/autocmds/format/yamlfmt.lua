local yamlfmt = require("abide").Abide:new("yamlfmt")

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.yaml", "*.yml" },
	callback = function()
		local filetype = yamlfmt:get_filetype()
		if not yamlfmt:check_filetypes(filetype, { "yaml", "yml" }) then
			return
		end

		if not yamlfmt:check_executable() then
			return
		end

		local stdin = yamlfmt:get_buffer_lines()

		local argv = { "yamlfmt", "-" }

		local bufnr = yamlfmt:get_bufnr()
		yamlfmt:command({
			bufnr = bufnr,
			argv = argv,
			stdin = stdin,
			has_config = false,
			config_path = nil,
		})
	end,
})
