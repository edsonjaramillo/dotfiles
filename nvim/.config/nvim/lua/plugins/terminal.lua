---@module 'lazy'
---@type LazySpec[]
return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				hide_numbers = true,
			})
		end,
	},
}
