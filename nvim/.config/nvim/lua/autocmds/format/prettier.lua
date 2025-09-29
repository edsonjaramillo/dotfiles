local prettier = require("abide").Abide:new("prettier")
-- Auto-format JavaScript/TypeScript/JSON files with prettier on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.js", "*.jsx", "*.mjs", "*.ts", "*.tsx", "*.json" },
	callback = function()
		local filetype = prettier:get_filetype()
		local filetypes =
			{ "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "jsonc" }
		if not prettier:check_filetypes(filetype, filetypes) then
			return
		end

		if not prettier:check_executable() then
			return
		end

		local lines = prettier:get_buffer_lines()
		local input = table.concat(lines, "\n")

		local filename = prettier:get_filename()
		local argv = { "prettier", "--stdin-filepath", filename }

		local bufnr = prettier:get_bufnr()
		prettier:command(bufnr, argv, input)
	end,
})
