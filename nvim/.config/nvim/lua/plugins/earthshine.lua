---@module 'lazy'
---@type LazySpec[]
return {
	{
		dir = "~/code/nvim-plugins/earthshine",
		lazy = false,
		priority = 1000,
		config = function()
			require("earthshine").setup()
		end,
	},
}
