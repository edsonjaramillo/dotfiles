local fzf = require("fzf-lua")
local wk = require("which-key")

wk.add({
	mode = "n",
	{
		"<leader>l",
		group = "LSP",
	},
	{
		"<leader>lR",
		"<cmd>LspRestart<cr>",
		desc = "Restart LSP",
	},
	{
		"<leader>ld",
		function()
			fzf.lsp_document_diagnostics()
		end,
		desc = "Diagnostics (Snacks)",
	},
	{
		"<leader>lD",
		function()
			fzf.lsp_workspace_diagnostics()
		end,
		desc = "Diagnostics (Workspace)",
	},
	{
		"<leader>lr",
		vim.lsp.buf.rename,
		desc = "Rename (LSP)",
	},
	{
		"<leader>lc",
		function()
			require("fzf-lua").lsp_code_actions()
		end,
	},
	{
		"K",
		vim.lsp.buf.hover({
			focusable = false,
		}),
		desc = "Hover (LSP)",
	},
})
