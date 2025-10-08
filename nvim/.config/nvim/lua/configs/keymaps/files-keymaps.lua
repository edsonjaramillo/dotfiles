local files_helper = require("helpers.files-helpers")
local snacks = require("snacks")
local snacks_helper = require("helpers.snacks-helpers")
local wk = require("which-key")

wk.add({
	mode = "n",
	{
		"<leader>f",
		group = "Finder",
	},
	{
		"<leader>ff",
		function()
			snacks.picker.files({
				hidden = files_helper.is_dotfiles,
				exclude = snacks_helper.folder_exclude,
			})
		end,
		desc = "Find Files (Snacks)",
	},
	{
		"<leader>fr",
		function()
			snacks.picker.recent({
				filter = { paths = snacks_helper.priotize_cwd },
				matcher = { cwd_bonus = true },
			})
		end,
		desc = "Recent Files (Snacks)",
	},
	{
		"<leader>fc",
		function()
			snacks.picker.files({ cwd = vim.fn.stdpath("config"), hidden = true })
		end,
		desc = "Config Files (Snacks)",
	},
	{
		"<leader>fp",
		function()
			snacks.picker.files({ cwd = "~/code/nvim-plugins/" })
		end,
		desc = "Plugin Files (Snacks)",
	},
})
