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
		"<leader>b]",
		"<cmd>bnext<cr>",
		desc = "Go to next buffer",
	},
	{
		"<leader>b[",
		"<cmd>bprevious<cr>",
		desc = "Go to previous buffer",
	},
	{
		"<leader>bd",
		"<cmd>bdelete<cr>",
		desc = "Close current buffer",
	},
	{
		"<leader>bW",
		"<cmd>%bd|e#|bd#<cr>",
		desc = "Close all buffers except current",
	},
})
