local flash = require("flash")
local wk = require("which-key")

wk.add({
	mode = { "n", "x", "o" },
	{
		"<leader>j",
		function()
			flash.jump()
		end,
	},
})

wk.add({
	mode = { "x", "o" },
	{
		"R",
		function()
			flash.treesitter_search()
		end,
		desc = "Treesitter Search",
	},
})
