local snacks = require("snacks")
local wk = require("which-key")

wk.add({
	mode = "n",
	{
		"<leader>l",
		group = "LSP",
	},
	{
		"<leader>ld",
		function()
			snacks.picker.diagnostics()
		end,
		desc = "Diagnostics (Snacks)",
	},
	{
		"<leader>lr",
		vim.lsp.buf.rename,
		desc = "Rename (LSP)",
	},
	{
		"<leader>lR",
		function()
			snacks.picker.lsp_references()
		end,
		desc = "References (Snacks)",
	},
	{
		"K",
		vim.lsp.buf.hover({
			focusable = false,
		}),
		desc = "Hover (LSP)",
	},
})
