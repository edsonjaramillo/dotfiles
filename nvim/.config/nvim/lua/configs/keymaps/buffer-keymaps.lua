local snacks = require("snacks")
local wk = require("which-key")

wk.add({
	mode = { "n" },
	{
		"<leader>b",
		{ group = "Buffer" },
	},
	{
		"<leader>bf",
		function()
			snacks.picker.buffers()
		end,
		desc = "List and go to buffer",
	},
	{
		"<leader>bW",
		"<cmd>%bd|e#|bd#<cr>",
		desc = "Close all buffers except current",
	},
})

wk.add({
	mode = { "n" },
	{
		"<leader>tn",
		"<cmd>tabnew<cr>",
		desc = "Open new tab",
	},
	{
		"<leader>tq",
		"<cmd>tabclose<cr>",
		desc = "Close current tab",
	},
	{
		"[t",
		"<cmd>tabprevious<cr>",
		desc = "Go to previous tab",
	},
	{
		"]t",
		"<cmd>tabnext<cr>",
		desc = "Go to next tab",
	},
	{
		"<leader>to",
		"<cmd>tabonly<cr>",
		desc = "Close all other tabs",
	},
})
