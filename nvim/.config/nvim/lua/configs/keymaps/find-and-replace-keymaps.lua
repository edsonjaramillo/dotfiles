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
			local flags = {}

			local is_dotfiles = files_helper.is_dotfiles()
			if is_dotfiles then
				table.insert(flags, "--hidden")
			end

			local concat_flags = table.concat(flags, " ")

			require("grug-far").open({
				prefills = {
					flags = concat_flags,
				},
			})
		end,
		desc = "Open Spectre",
	},
	{
		"<leader>rw",
		[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
		desc = "Replace Word Under Cursor",
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
