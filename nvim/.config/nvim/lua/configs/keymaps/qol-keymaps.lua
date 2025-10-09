local printify = require("macros.printify")
local wk = require("which-key")

local esc_keys = { "jk", "kj" }
for _, key in ipairs(esc_keys) do
	vim.keymap.set({ "i", "v", "x", "s", "c" }, key, "<Esc>", {
		noremap = true,
		silent = true,
		desc = "Exit to Normal mode",
	})
end

-- print commands
wk.add({
	mode = "n",
	{
		"<leader>p",
		group = "Print",
	},
	{
		"<leader>pw",
		function()
			printify.debugUnderCursor()
		end,
		desc = "Print Debug Statement Under Cursor",
	},
})
