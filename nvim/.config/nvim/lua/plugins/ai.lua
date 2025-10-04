return {
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_filetypes = {
				["copilot-chat"] = false,
			}
		end,
	},
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	event = "InsertEnter",
	-- 	dependencies = {
	-- 		"copilotlsp-nvim/copilot-lsp",
	-- 	},
	-- 	cmd = "Copilot",
	-- 	opts = {},
	-- 	config = function()
	-- 		require("copilot").setup({
	-- 			suggestion = {
	-- 				auto_trigger = true,
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
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
