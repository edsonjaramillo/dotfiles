local wk = require("which-key")

wk.add({
	mode = "n",
	{
		"<leader>t",
		group = "Terminal",
	},
	{
		"<leader>tt",
		"<cmd>ToggleTerm<CR>",
		desc = "Toggle Terminal (ToggleTerm)",
	},
})
