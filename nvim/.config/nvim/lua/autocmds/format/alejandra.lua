local alejandra = require("abide").Abide:new("alejandra")

-- Auto-format sh/bash files with shfmt on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.nix" },
	callback = function()
		local filetype = alejandra:get_filetype()
		if not alejandra:check_filetypes(filetype, { "nix" }) then
			return
		end

		if not alejandra:check_executable() then
			return
		end

		local bufnr = alejandra:get_bufnr()
		local stdin = alejandra:get_buffer_lines(bufnr)

		local argv = { "alejandra", "-" }

		alejandra:command({
			bufnr = bufnr,
			argv = argv,
			stdin = stdin,
			has_config = false,
			config_path = nil,
		})
	end,
})
