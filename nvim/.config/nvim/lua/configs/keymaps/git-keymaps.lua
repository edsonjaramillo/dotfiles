local fzf = require("fzf-lua")
local wk = require("which-key")

wk.add({
	mode = "n",
	{
		"<leader>g",
		group = "Git",
	},
	{
		"<leader>gb",
		":Gitsigns blame_line<CR>",
		desc = "Git Blame Line",
	},
	{
		"<leader>gd",
		":Gitsigns diffthis<CR>",
		desc = "Git Diff This",
	},
	{
		"<leader>ghp",
		":Gitsigns preview_hunk<CR>",
		desc = "Git Hunk Preview",
	},
	{
		"<leader>ghr",
		":Gitsigns reset_hunk<CR>",
		desc = "Git Reset Hunk",
	},
	{
		"<leader>ghs",
		":Gitsigns stage_hunk<CR>",
		desc = "Git Stage Hunk",
	},
	{
		"<leader>ghu",
		":Gitsigns undo_stage_hunk<CR>",
		desc = "Git Undo Stage Hunk",
	},
	{
		"<leader>gs",
		function()
			fzf.git_status()
		end,
		desc = "Git Status (FZF)",
	},
})
