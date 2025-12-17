---@module 'lazy'
---@type LazySpec[]
return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers",
					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level, _, _)
						local icon = level:match("error") and " " or " "
						return " " .. icon .. count
					end,
					numbers = "buffer_id",
				},
			})
		end,
	},
}
