---@module 'lazy'
---@type LazySpec[]
return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = require("lualine.themes.earthshine"),
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff" },
					lualine_c = { "diagnostics" },
					lualine_x = { "filename", "encoding", "filetype", "lsp_status" },
					lualine_y = { "windows" },
					lualine_z = {
						{
							--- macro recording on statusline
							require("noice").api.statusline.mode.get,
							cond = require("noice").api.statusline.mode.has,
							color = { fg = "#ffffff", bg = "#550000" },
						},
					},
				},
			})
		end,
	},
}
