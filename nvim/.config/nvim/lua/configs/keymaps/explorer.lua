local files_utils = require("helpers.files-utils")
local oil = require("oil")
local wk = require("which-key")

wk.add({
	mode = "n",
	{
		"<leader>e",
		function()
			if files_utils.is_dotfiles then
				oil.setup({ view_options = { show_hidden = true } })
			else
				oil.setup({ view_options = { show_hidden = false } })
			end
			oil.open()
		end,
		desc = "Open Explorer (Oil)",
	},
})
