local snacks = require("snacks")
local snacks_utils = require("helpers.snacks-utils")
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
			-- if cwd is ~/dotfiles, show hidden files
			snacks.picker.files({
				hidden = snacks_utils.is_dotfiles,
				exclude = snacks_utils.folder_exclude,
			})
		end,
		desc = "Find Files (Snacks)",
	},
	{
		"<leader>fr",
		function()
			snacks.picker.recent({
				filter = { paths = { snacks_utils.priotize_cwd } },
				matcher = {
					cwd_bonus = true,
				},
			})
		end,
	},
	{
		"<leader>fc",
		function()
			snacks.picker.files({ cwd = vim.fn.stdpath("config"), hidden = true })
		end,
		desc = "Config Files (Snacks)",
	},
	-- snacks file picker where cwd is ~/code/nvim-plugins/
	{
		"<leader>fp",
		function()
			snacks.picker.files({ cwd = "~/code/nvim-plugins/" })
		end,
		desc = "Plugin Files (Snacks)",
	},
})
