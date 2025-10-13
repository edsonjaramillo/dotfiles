local wk = require("which-key")
local Terminal = require("toggleterm.terminal").Terminal

wk.add({
	mode = "n",
	{
		"<leader>t",
		group = "Terminal",
	},
	{
		"<leader>tt",
		function()
			local term = Terminal:new({
				hidden = true,
				direction = "float",
				id = 1,
			})
			term:toggle()
		end,
		desc = "Terminal (toggleterm)",
	},
	{
		"<leader>tl",
		function()
			local lazygit = Terminal:new({
				cmd = "lazygit",
				hidden = true,
				direction = "float",
				id = 2,
			})
			lazygit:toggle()
		end,
		desc = "Lazygit (ToggleTerm)",
	},
	{
		"<leader>tf",
		function()
			local frontend = Terminal:new({
				hidden = true,
				direction = "float",
				id = 3,
			})
			frontend:toggle()
		end,
		desc = "Frontend (toggleterm)",
	},
	{
		"<leader>tb",
		function()
			local backend = Terminal:new({
				hidden = true,
				direction = "float",
				id = 4,
			})
			backend:toggle()
		end,
		desc = "Backend (toggleterm)",
	},
})
