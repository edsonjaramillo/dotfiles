return {
	dir = "~/code/oss/earthshine.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("earthshine").setup()
	end,
}
