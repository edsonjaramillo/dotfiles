return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
		lazy = false,
	},
	{
		"windwp/nvim-ts-autotag",
	},
	{
		"nvim-focus/focus.nvim",
		version = "*",
		config = function()
			require("focus").setup({
				autoresize = {
					enable = false,
				},
				split = {
					bufnew = true,
				},
				ui = {
					relativenumber = true,
					winhighlight = false,
				},
			})
		end,
	},
}
