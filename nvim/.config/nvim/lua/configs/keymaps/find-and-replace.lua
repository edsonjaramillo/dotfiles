local wk = require("which-key")

wk.add({
	mode = "n",
	{
		"<leader>r",
		group = "Replace",
	},
	{
		"<leader>ro",
		function()
			require("spectre").open()
		end,
		desc = "Open Spectre",
	},
	{
		"<leader>rc",
		function()
			require("spectre").close()
		end,
		desc = "Close Spectre",
	},
	{
		"<leader>rpv",
		function()
			require("spectre").open({
				search_text = ': "\\^',
				replace_text = ': "',
				path = "package.json",
			})
		end,
		desc = "Remove all ^ from package.json versions",
	},
})
