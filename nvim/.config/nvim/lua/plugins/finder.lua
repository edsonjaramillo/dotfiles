return {
	{
		"folke/snacks.nvim",
		opts = {
			picker = {},
			dashboard = {
				preset = {
					keys = {
						{
							icon = " ",
							key = "f",
							desc = "Find File",
							action = function()
								local cwd = vim.fn.getcwd()
								local is_dotfiles = cwd == vim.fn.expand("~") .. "/dotfiles"
								require("snacks").picker.files({
									hidden = is_dotfiles,
									exclude = { "node_modules", ".git", "dist" },
								})
							end,
						},
						{
							icon = "󰈞 ",
							key = "r",
							desc = "Recent Files",
							action = function()
								require("snacks").picker.recent({
									filter = { paths = { [vim.fn.getcwd()] = true } },
									matcher = {
										cwd_bonus = true,
									},
								})
							end,
						},
						{
							icon = "󰍉 ",
							key = "g",
							desc = "Live Grep",
							action = function()
								local cwd = vim.fn.getcwd()
								local is_dotfiles = cwd == vim.fn.expand("~") .. "/dotfiles"
								require("snacks").picker.grep({
									hidden = is_dotfiles,
									matcher = {
										cwd_bonus = true,
									},
								})
							end,
						},
						{
							icon = "󰉓 ",
							key = "e",
							desc = "Oil Explorer",
							action = function()
								local cwd = vim.fn.getcwd()
								local is_dotfiles = cwd == vim.fn.expand("~") .. "/dotfiles"

								local oil = require("oil")
								if is_dotfiles then
									oil.setup({ view_options = { show_hidden = true } })
								else
									oil.setup({ view_options = { show_hidden = false } })
								end
								oil.open(".")
							end,
						},
						{
							icon = "󰒲 ",
							key = "L",
							desc = "Lazy",
							action = ":Lazy",
							enabled = package.loaded.lazy ~= nil,
						},
						{
							icon = "󰏗 ",
							key = "m",
							desc = "Mason",
							action = ":Mason",
						},
						{
							icon = " ",
							key = "q",
							desc = "Quit",
							action = ":qa",
						},
					},
				},
			},
		},
	},
}
