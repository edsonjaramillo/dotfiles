---@module 'lazy'
---@type LazySpec[]
return {
	{
		dir = "~/code/nvim-plugins/earthshine",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("earthshine")
		end,
	},
}
