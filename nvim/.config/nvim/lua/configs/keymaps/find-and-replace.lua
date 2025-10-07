local files_helper = require("helpers.files-helpers")
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
			require("grug-far").open({
				prefills = {
					search = ': "\\^',
					replacement = ': "',
					filesFilter = "package.json",
				},
			})
		end,
		desc = "Remove all ^ from package.json versions",
	},
})

wk.add({
	mode = "x",
	{
		"<leader>r",
		group = "Replace",
	},
	{
		"<leader>ro",
		function()
			local cwd = vim.fn.getcwd()
			require("grug-far").with_visual_selection({
				prefills = {
					paths = cwd,
					flags = files_helper.is_dotfiles and "--hidden" or nil,
				},
			})
		end,
		desc = "Open Grug-FAR with visual selection",
	},
})
