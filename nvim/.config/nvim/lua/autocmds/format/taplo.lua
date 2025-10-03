local taplo = require("abide").Abide:new("taplo")

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.toml" },
	callback = function()
		local filetype = taplo:get_filetype()

		local filetypes = {
			"toml",
		}

		if not taplo:check_filetypes(filetype, filetypes) then
			return
		end

		if not taplo:check_executable() then
			return
		end

		local stdin = taplo:get_buffer_lines()

		local argv = { "taplo", "fmt", "-" }

		local bufnr = taplo:get_bufnr()
		taplo:command({
			bufnr = bufnr,
			argv = argv,
			stdin = stdin,
			has_config = false,
			config_path = nil,
		})
	end,
})
