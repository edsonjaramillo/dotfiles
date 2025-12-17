local printify = require("macros.printify")
local wk = require("which-key")

local esc_keys = { "jk", "kj" }
for _, key in ipairs(esc_keys) do
	vim.keymap.set({ "i", "v", "x", "s", "c" }, key, "<Esc>", {
		noremap = true,
		silent = true,
		desc = "Exit to Normal mode",
	})
end

wk.add({
	mode = "n",
	{
		"<leader>i",
		":source $MYVIMRC<CR>:luafile %<CR>",
		desc = "Source $MYVIMRC and Luafile Current File",
	},
	{
		"<leader>R",
		function()
			vim.cmd("Lazy reload earthshine.nvim")
			vim.cmd("colorscheme earthshine")
		end,
		desc = "Reload Lazy earthshine plugin and colorscheme earthshine",
	},
})

-- print commands
wk.add({
	mode = "n",
	{
		"<leader>p",
		group = "Print",
	},
	{
		"<leader>pw",
		function()
			printify.debugUnderCursor()
		end,
		desc = "Print Debug Statement Under Cursor",
	},
})

wk.add({
	mode = "i",
	{
		"<C-h>",
		"<Left>",
		desc = "Move cursor left",
	},
	{
		"<C-l>",
		"<Right>",
		desc = "Move cursor right",
	},
	{
		"<C-j>",
		"<Down>",
		desc = "Move cursor down",
	},
	{
		"<C-k>",
		"<Up>",
		desc = "Move cursor up",
	},
	{
		"<C-s>",
		function()
			require("flash").jump()
		end,
		desc = "Flash Jump",
	},
	{
		"<C-b>",
		function()
			vim.cmd("normal! b")
		end,
		desc = "Move cursor to previous word",
	},
	{
		"<C-w>",
		function()
			vim.cmd("normal! w")
		end,
		desc = "Move to next word",
	},
	{
		"<C-d>",
		function()
			vim.cmd("normal! db")
		end,
		desc = "Delete previous word",
	},
	{
		"<C-l>",
		function()
			vim.cmd("normal! _D")
		end,
		desc = "Delete to end of line",
	},
	{
		"<C-[>",
		function()
			vim.diagnostic.jump({ count = -1 })
			vim.cmd("normal! zz")
		end,
		desc = "Go to previous diagnostic",
	},
	{
		"<C-]>",
		function()
			vim.diagnostic.jump({ count = 1 })
			vim.cmd("normal! zz")
		end,
		desc = "Go to next diagnostic",
	},
	{
		"<C-c>",
		function()
			vim.cmd("normal! ciw")
			vim.cmd("normal! l")
		end,
		desc = "Change inner word and move cursor to the right",
	},
	{
		"<C-u>",
		function()
			vim.cmd("normal! u")
		end,
		desc = "Undo",
	},
	{
		"<C-r>",
		function()
			vim.cmd("normal! <C-r>")
		end,
		desc = "Redo",
	},
})
