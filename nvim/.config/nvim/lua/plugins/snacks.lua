local files_utils = require("helpers.files-utils")
local oil_utils = require("helpers.oil-utils")
local snacks_utils = require("helpers.snacks-utils")

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
								require("snacks").picker.files({
									hidden = files_utils.is_dotfiles,
									exclude = snacks_utils.folder_exclude,
								})
							end,
						},
						{
							icon = "󰈞 ",
							key = "r",
							desc = "Recent Files",
							action = function()
								require("snacks").picker.recent({
									filter = { paths = snacks_utils.priotize_cwd },
									matcher = { cwd_bonus = true },
								})
							end,
						},
						{
							icon = "󰍉 ",
							key = "g",
							desc = "Live Grep",
							action = function()
								require("snacks").picker.grep({
									hidden = files_utils.is_dotfiles,
									matcher = { cwd_bonus = true },
								})
							end,
						},
						{
							icon = "󰉓 ",
							key = "e",
							desc = "Oil Explorer",
							action = function()
								if files_utils.is_dotfiles then
									oil_utils.enable_hidden()
								else
									oil_utils.disable_hidden()
								end
								require("oil").open()
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
