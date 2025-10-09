local snack_helpers = require("helpers.snacks-helpers")
local snacks = require("snacks")
local wk = require("which-key")

wk.add({
	mode = "n",
	{
		"<leader>s",
		group = "Search",
	},
	{
		"<leader>sm",
		function()
			snacks.picker.man()
		end,
		desc = "Man Pages (Snacks)",
	},
	{
		"<leader>sH",
		function()
			snacks.picker.highlights()
		end,
		desc = "Highlights",
	},
	{
		"<leader>sd",
		function()
			snacks.picker.lsp_symbols()
		end,
		desc = "Go to Definition (Snacks)",
	},
	{
		"<leader>sg",
		function()
			snacks.picker.grep({ hidden = true, exclude = snack_helpers.folder_exclude })
		end,
		desc = "Grep (Snacks)",
	},
	{
		"<leader>sk",
		function()
			snacks.picker.keymaps()
		end,
		desc = "Keymaps (Snacks)",
	},
	{
		"<leader>sC",
		function()
			snacks.picker.commands()
		end,
		desc = "Commands (Snacks)",
	},
	{
		"<leader>sx",
		"<cmd>nohlsearch<CR>",
		desc = "Clear search highlight",
	},
})
