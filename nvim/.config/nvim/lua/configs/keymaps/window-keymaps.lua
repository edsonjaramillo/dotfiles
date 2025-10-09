local buffer_utils = require("helpers.buffer-helpers")
local wk = require("which-key")

wk.add({
	mode = "n",
	{
		"<leader>w",
		group = "Window",
	},
	{
		"<leader>ww",
		"<C-w>w",
		desc = "Switch Window",
	},
	{
		"<leader>wx",
		"<C-w>x",
		desc = "Swap Window",
	},
	{
		"<leader>wq",
		function()
			buffer_utils.close_buffer_keep_window()
		end,
		desc = "Quit Window",
	},
	{
		"<leader>w-",
		"<C-w>s",
		desc = "Split Window Horizontally",
	},
	{
		"<leader>w|",
		"<C-w>v",
		desc = "Split Window Vertically",
	},
	{
		"<leader>wh",
		"<C-w>h",
		desc = "Move to Left Window",
	},
	{
		"<leader>wj",
		"<C-w>j",
		desc = "Move to Lower Window",
	},
	{
		"<leader>wk",
		"<C-w>k",
		desc = "Move to Upper Window",
	},
	{
		"<leader>wl",
		"<C-w>l",
		desc = "Move to Right Window",
	},
})
