local files_utils = require("helpers.files-utils")
local oil = require("oil")
local oil_utils = require("helpers.oil-utils")
local wk = require("which-key")

wk.add({
	mode = "n",
	{
		"<leader>e",
		function()
			if files_utils.is_dotfiles then
				oil_utils.enable_hidden()
			else
				oil_utils.disable_hidden()
			end
			oil.open()
		end,
		desc = "Open Explorer (Oil)",
	},
})
