local files_helper = require("helpers.files-helpers")
local oil = require("oil")
local oil_helper = require("helpers.oil-helpers")
local wk = require("which-key")

wk.add({
	mode = "n",
	{
		"<leader>e",
		function()
			if files_helper.is_dotfiles then
				oil_helper.enable_hidden()
			else
				oil_helper.disable_hidden()
			end
			oil.open()
		end,
		desc = "Open Explorer (Oil)",
	},
})
