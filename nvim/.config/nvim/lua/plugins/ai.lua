---@module 'lazy'
---@type LazySpec[]
return {
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		cmd = "Copilot",
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
			filetypes = { markdown = true, help = true },
		},
		{
			"CopilotC-Nvim/CopilotChat.nvim",
			dependencies = {
				{ "nvim-lua/plenary.nvim", branch = "master" },
			},
			build = "make tiktoken",
			opts = {
				question_header = "## User",
				answer_header = "## Copilot",
				error_header = "## Error",
			},
			config = function(_, opts)
				local chat = require("CopilotChat")
				local hostname = io.popen("hostname"):read("*a"):gsub("%s+", "")
				local user = hostname or vim.env.USER or "User"
				opts.question_header = "  " .. user .. " "
				opts.answer_header = "  Copilot "
				chat.setup(opts)
			end,
		},
	},
}
