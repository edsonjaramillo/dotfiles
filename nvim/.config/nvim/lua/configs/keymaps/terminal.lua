local wk = require("which-key")

wk.add({
	{
		"<leader>t",
		group = "Terminal",
	},
	{
		"<leader>tt",
		"<cmd>ToggleTerm<CR>",
		desc = "Toggle Terminal (ToggleTerm)",
	},
}, { mode = "n" })
