local shfmt = require("abide").Abide:new("shfmt")

-- Auto-format sh/bash files with shfmt on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.sh", "*.bash", "*.zsh", ".zshrc" },
	callback = function()
		local filetype = shfmt:get_filetype()
		if not shfmt:check_filetypes(filetype, { "sh", "bash", "zsh" }) then
			return
		end

		if not shfmt:check_executable() then
			return
		end

		local stdin = shfmt:get_buffer_lines()

		local argv = { "shfmt", "-filename", "stdin", "-" }

		local bufnr = shfmt:get_bufnr()
		shfmt:command({
			bufnr = bufnr,
			argv = argv,
			stdin = stdin,
			has_config = false,
			config_path = nil,
		})
	end,
})
