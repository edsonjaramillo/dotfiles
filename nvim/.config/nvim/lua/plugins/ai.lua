local prompts = {
	-- Code related prompts
	Explain = "Please explain how the following code works.",
	Review = "Please review the following code and provide suggestions for improvement.",
	Tests = "Please explain how the selected code works, then generate unit tests for it.",
	Refactor = "Please refactor the following code to improve its clarity and readability.",
	FixCode = "Please fix the following code to make it work as intended.",
	FixError = "Please explain the error in the following text and provide a solution.",
	BetterNamings = "Please provide better names for the following variables and functions.",
	Documentation = "Please provide documentation for the following code.",
	SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
	SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
	-- Text related prompts
	Summarize = "Please summarize the following text.",
	Spelling = "Please correct any grammar and spelling errors in the following text.",
	Wording = "Please improve the grammar and wording of the following text.",
	Concise = "Please rewrite the following text to make it more concise.",
}

return {
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_filetypes = {
				["copilot-chat"] = false,
			}
		end,
	},
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
				prompts = prompts,
			},
			config = function(_, opts)
				local chat = require("CopilotChat")
				local hostname = io.popen("hostname"):read("*a"):gsub("%s+", "")
				local user = hostname or vim.env.USER or "User"
				opts.question_header = "  " .. user .. " "
				opts.answer_header = "  Copilot "
				-- override the git prompts message
				opts.prompts.Commit = {
					prompt = '> #git:staged\n\nWrite commit message with commitizen convention. Write clear, informative commit messages that explain the "what" and "why" behind changes, not just the "how".',
				}
				chat.setup(opts)
			end,
			keys = {
				{
					"<leader>ap",
					function()
						require("CopilotChat").select_prompt({
							context = { "buffers" },
						})
					end,
					desc = "Chat with Copilot",
				},
			},
		},
	},
}
