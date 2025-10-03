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
		"<leader>lc",
		vim.lsp.buf.code_action,
		desc = "Code Action (LSP)",
	},
	{
		"<leader>li",
		function()
			snacks.picker.lsp_implementations()
		end,
		desc = "Go to Implementation (Snacks)",
	},
	{
		"<leader>lR",
		function()
			snacks.picker.lsp_references()
		end,
		desc = "References (Snacks)",
	},
	{
		"<leader>lS",
		function()
			snacks.picker.lsp_workspace_symbols()
		end,
		desc = "Workspace Symbols (Snacks)",
	},
	{
		"K",
		vim.lsp.buf.hover({
			focusable = false,
		}),
		desc = "Hover (LSP)",
	},
})
