---@module 'lazy'
---@type LazySpec[]
return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@module 'flash'
		---@type Flash.Config
		opts = {
			search = {
				mode = "search",
			},
		},
	},
}
