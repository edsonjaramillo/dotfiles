local colors = {
	ERROR = "#e35659",
	WARN = "#f8cc5a",
	INFO = "#409cff",
	DEBUG = "#aeaeae",
}

local highlights = { "Border", "Icon", "Title" }

---@module 'lazy'
---@type LazySpec[]
return {
	{
		"rcarriga/nvim-notify",
		opts = {
			background_colour = "#030303",
			time_formats = {
				notification = "%-I:%M:%S %p",
			},
			timeout = 1000,
		},
		config = function()
			for _, highlight in ipairs(highlights) do
				for level, color in pairs(colors) do
					vim.api.nvim_set_hl(0, "Notify" .. level .. highlight, { fg = color })
				end
			end
		end,
	},
}
