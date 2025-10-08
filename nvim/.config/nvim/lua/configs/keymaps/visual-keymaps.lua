local wk = require("which-key")

-- Visual mode mappings
wk.add({
	mode = "x",
	{
		"<leader>v",
		group = "Visual",
	},
	{
		"<leader>vc",
		":CommentToggle<CR>",
		desc = "Comment Toggle",
	},
	{
		"<leader>va",
		"ggVG",
		desc = "Select All",
	},
})

-- Normal mode mappings for visual selections
wk.add({
	mode = "n",
	{
		"<leader>v",
		group = "Visual",
	},
	{
		"<leader>va",
		"ggVG",
		desc = "Select All",
	},
	{
		"<leader>vl",
		"$V",
		desc = "Select Line",
	},
})

-- Move selected lines up and down
wk.add({
	mode = "x",
	{ "<A-k>", ":m '<-2<CR>gv=gv", desc = "Move Line Up" },
	{ "<A-j>", ":m '>+1<CR>gv=gv", desc = "Move Line Down" },
})

-- Add sort functionality
wk.add({
	mode = "x",
	{ "<leader>sa", ":'<,'>sort<CR>", desc = "Sort Ascending" },
	{ "<leader>sd", ":'<,'>sort!<CR>", desc = "Sort Descending" },
	{ "<leader>su", ":'<,'>sort u<CR>", desc = "Sort Unique" },
	{ "<leader>sn", ":'<,'>sort n<CR>", desc = "Sort Numerically" },
	{ "<leader>sr", ":'<,'>sort r<CR>", desc = "Sort Reverse" },
	{ "<leader>si", ":'<,'>sort i<CR>", desc = "Sort Ignore Case" },
})
