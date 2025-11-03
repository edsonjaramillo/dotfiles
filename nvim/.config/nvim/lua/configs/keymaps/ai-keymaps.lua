local notify = require("notify")
local wk = require("which-key")

local commit_prompt = [[
Write commit message with commitizen convention.
Write clear, informative commit messages that explain the 'what' and 'why' behind changes,
not just the 'how'. Use list format if multiple changes.
]]

local explain_prompt = [[
Explain the following code in detail:	
]]

local review_prompt = [[
Review the following code and provide suggestions for improvement:
]]

local Documentation_prompt = [[
Please provide documentation for the following code. :
]]

local Type_prompt = [[
Please provide type annotations for the following code. :
]]

wk.add({
	mode = "x",
	{ "<leader>a", group = "AI" },
	{
		"<leader>ae",
		function()
			require("CopilotChat").ask(explain_prompt, {
				model = "gpt-5-mini",
				sticky = { "#selection" },
			})
		end,
		desc = "Explain Code",
	},
	{
		"<leader>ar",
		function()
			require("CopilotChat").ask(review_prompt, {
				model = "gpt-5-mini",
				sticky = { "#selection" },
			})
		end,
		desc = "Review Code",
	},
	{
		"<leader>ad",
		function()
			require("CopilotChat").ask(Documentation_prompt, {
				model = "gpt-5-mini",
				sticky = { "#selection" },
			})
		end,
		desc = "Document Code",
	},
	{
		"<leader>at",
		function()
			require("CopilotChat").ask(Type_prompt, {
				model = "gpt-5-mini",
				sticky = { "#selection" },
			})
		end,
		desc = "Type Annotations",
	},
})

wk.add({
	mode = "n",
	{
		"<leader>a",
		group = "AI",
	},
	{
		"<leader>ac",
		function()
			require("local-plugins.ai-yank").commit(commit_prompt)
		end,
		desc = "Git Commit Message",
	},
	{
		"<leader>ao",
		function()
			require("CopilotChat").open()
		end,
		desc = "Open Chat",
	},
	{
		"<leader>aw",
		function()
			require("CopilotChat").close()
		end,
		desc = "Close Chat",
	},
})
