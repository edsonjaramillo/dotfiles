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
		"<leader>bw",
		"<cmd>bd<cr>",
		desc = "Close current buffer",
	},
	{
		"<leader>bW",
		"<cmd>%bd|e#|bd#<cr>",
		desc = "Close all buffers except current",
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
		"<leader>bv",
		"<cmd>vsplit | enew<cr>",
		desc = "Open new buffer in vertical split",
	},
	{
		"<leader>bh",
		"<cmd>split | enew<cr>",
		desc = "Open new buffer in horizontal split",
	},
})
