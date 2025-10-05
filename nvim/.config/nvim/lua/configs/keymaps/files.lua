local snacks = require("snacks")
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
			local cwd = vim.fn.getcwd()
			local is_dotfiles = cwd == vim.fn.expand("~") .. "/dotfiles"
			snacks.picker.files({
				hidden = is_dotfiles,
				exclude = { "node_modules", ".git", "dist" },
			})
		end,
		desc = "Find Files (Snacks)",
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
