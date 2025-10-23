local files_helper = require("helpers.files-helpers")
local fzf = require("fzf-lua")
local oil_helper = require("helpers.oil-helpers")
local snacks_helper = require("helpers.snacks-helpers")

---@module 'lazy'
---@type LazySpec[]
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
									hidden = files_helper.is_dotfiles,
									exclude = snacks_helper.folder_exclude,
								})
							end,
						},
						{
							icon = "󰈞 ",
							key = "r",
							desc = "Recent Files",
							action = function()
								require("snacks").picker.recent({
									filter = { paths = snacks_helper.priotize_cwd },
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
									hidden = files_helper.is_dotfiles,
									matcher = { cwd_bonus = true },
								})
							end,
						},
						{
							icon = "󰊢 ",
							key = "s",
							desc = "Git Status",
							action = function()
								require("fzf-lua").git_status()
							end,
						},
						{
							icon = "󰉓 ",
							key = "e",
							desc = "Oil Explorer",
							action = function()
								if files_helper.is_dotfiles then
									oil_helper.enable_hidden()
								else
									oil_helper.disable_hidden()
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
	{
		dir = "~/code/nvim-plugins/extra-pickers.nvim",
	},
}
