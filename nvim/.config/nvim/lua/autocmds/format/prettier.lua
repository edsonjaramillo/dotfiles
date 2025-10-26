local prettier = require("abide").Abide:new("prettier")

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.js", "*.jsx", "*.mjs", "*.ts", "*.tsx", "*.json", "*.jsonc", "*.css" },
	callback = function()
		local filetype = prettier:get_filetype()

		local filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
			"json",
			"jsonc",
			"css",
		}

		if not prettier:check_filetypes(filetype, filetypes) then
			return
		end

		if not prettier:check_executable() then
			return
		end

		local stdin = prettier:get_buffer_lines()

		local argv = { "prettier" }
		local prettier_config =
			prettier:find_config_file({ "prettier.config.mjs", "prettier.config.js" })
		if prettier_config then
			table.insert(argv, "--config")
			table.insert(argv, prettier_config)
		else
			table.insert(argv, "--use-tabs")
		end

		local filename = prettier:get_filename()
		table.insert(argv, "--stdin-filepath")
		table.insert(argv, filename)

		local bufnr = prettier:get_bufnr()
		prettier:command({
			bufnr = bufnr,
			argv = argv,
			stdin = stdin,
			has_config = prettier_config ~= nil,
			config_path = prettier_config,
		})
	end,
})
