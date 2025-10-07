local oil = require("oil")
local wk = require("which-key")

wk.add({
	mode = "n",
	{
		"<leader>e",
		function()
			local cwd = vim.fn.getcwd()
			local is_dotfiles = cwd == vim.fn.expand("~") .. "/dotfiles"
			if is_dotfiles then
				oil.setup({ view_options = { show_hidden = true } })
			else
				oil.setup({ view_options = { show_hidden = false } })
			end
			oil.open()
		end,
		desc = "Open Explorer (Oil)",
	},
})
