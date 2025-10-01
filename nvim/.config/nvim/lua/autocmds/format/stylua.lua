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

		local stdin = stylua:get_buffer_lines()

		local argv = { "stylua" }
		local stylua_config = stylua:find_config_file({ ".stylua.toml", "stylua.toml" })
		if stylua_config then
			table.insert(argv, "--config-path")
			table.insert(argv, stylua_config)
		end
		table.insert(argv, "-") -- Read from stdin

		local bufnr = stylua:get_bufnr()
		stylua:command({
			bufnr = bufnr,
			argv = argv,
			stdin = stdin,
			has_config = stylua_config ~= nil,
			config_path = stylua_config,
		})
	end,
})
