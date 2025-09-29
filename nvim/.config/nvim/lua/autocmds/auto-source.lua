local notify = require("notify")

local home = os.getenv("HOME") or ""
if home == "" then
	notify("HOME environment variable is not set", "error", { title = "Auto-source (autocmd)" })
	return
end

local plugins_path = home .. "/code/nvim-plugins/**/*.lua"
local nvim_config_path = home .. "/dotfiles/nvim/**/*.lua"

local patterns = { plugins_path, nvim_config_path }

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = patterns,
	callback = function(s)
		-- reload the file that was just saved
		vim.cmd.luafile(s.file)

		-- if home is not nil then replace absolute path with ~ for better readability
		if home then
			s.file = s.file:gsub(home, "~")
		end

		notify("Reloaded " .. s.file, "info", { title = "Resource" })
	end,
})
