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

-- better delete word in normal mode
wk.add({
	mode = "n",
	{
		"<C-w>",
		function()
			local col = vim.fn.col(".")
			local line = vim.fn.getline(".")
			if col > 1 and line:sub(col - 1, col - 1):match("%w") then
				vim.cmd("normal! b")
			end
			vim.cmd("normal! dW")
		end,
		desc = "Delete Word",
	},
})

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
