local fmt = require("custom.formatter")

-- Auto-format JavaScript/TypeScript/JSON files with prettier on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.js", "*.jsx", "*.mjs", "*.ts", "*.tsx", "*.json" },
	callback = function()
		local filetype = fmt.get_filetype()
		fmt.debug("prettier", "Filetype: " .. filetype)
		local filetypes =
			{ "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "jsonc" }
		if not fmt.check_filetype(filetype, filetypes) then
			return
		end

		if not fmt.check_executable("prettier") then
			return
		end

		local lines = fmt.get_buffer_lines()
		local input = table.concat(lines, "\n")

		local filename = fmt.get_filename()
		local argv = { "prettier", "--stdin-filepath", filename }

		local bufnr = fmt.get_bufnr()
		fmt.command("prettier", bufnr, argv, input)
	end,
})
