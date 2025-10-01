local wk = require("which-key")
local esc_keys = { "jk", "kj" }

for _, key in ipairs(esc_keys) do
	vim.keymap.set({ "i", "v", "x" }, key, "<Esc>", {
		noremap = true,
		silent = true,
		desc = "Exit to Normal mode",
	})
end

-- oil
wk.add({
	{ "<leader>e", "<cmd>Oil<CR>", desc = "Open Explorer (Oil)" },
}, { mode = "n" })

-- files (snacks)
local snacks = require("snacks")
wk.add({
	{
		"<leader>f",
		group = "Finder",
	},
	{
		"<leader>ff",
		function()
			-- if cwd is ~/dotfiles, show hidden files
			local cwd = vim.fn.getcwd()
			local is_dotfiles = cwd == vim.fn.expand("~") .. "/dotfiles"
			snacks.picker.files({ hidden = is_dotfiles })
		end,
		desc = "Find Files (Snacks)",
	},
	{
		"<leader>fb",
		function()
			snacks.picker.buffers()
		end,
		desc = "Find Buffers (Snacks)",
	},
	{
		"<leader>fc",
		function()
			snacks.picker.files({ cwd = vim.fn.stdpath("config"), hidden = true })
		end,
		desc = "Config Files (Snacks)",
	},
	-- snacks file picker where cwd is ~/code/nvim-plugins/
	{
		"<leader>fp",
		function()
			snacks.picker.files({ cwd = "~/code/nvim-plugins/" })
		end,
		desc = "Plugin Files (Snacks)",
	},
}, { mode = "n" })

-- lsp
wk.add({
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
		"<leader>lh",
		vim.lsp.buf.hover,
		desc = "Hover (LSP)",
	},
	{
		-- space to hover
		"K",
		vim.lsp.buf.hover({
			focusable = false,
		}),
		desc = "Hover (LSP)",
	},
}, { mode = "n" })

-- search
wk.add({
	{
		"<leader>s",
		group = "Search",
	},
	{
		"<leader>sm",
		function()
			snacks.picker.man()
		end,
		desc = "Man Pages (Snacks)",
	},
	{
		"<leader>sH",
		function()
			snacks.picker.highlights()
		end,
		desc = "Highlights",
	},
	{
		"<leader>sd",
		function()
			snacks.picker.lsp_symbols()
		end,
		desc = "Go to Definition (Snacks)",
	},
	{
		"<leader>sg",
		function()
			snacks.picker.grep({ hidden = true })
		end,
		desc = "Grep (Snacks)",
	},
	{
		"<leader>ss",
		function()
			snacks.picker.lines()
		end,
		desc = "Jumps (Snacks)",
	},
	{
		"<leader>sr",
		[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
		desc = "Replace Word Under Cursor",
	},
	{
		"<leader>sx",
		"<cmd>nohlsearch<CR>",
		desc = "Clear search highlight",
	},
}, { mode = "n" })

-- toggleterm
wk.add({
	{
		"<leader>t",
		group = "Terminal",
	},
	{
		"<leader>tt",
		"<cmd>ToggleTerm<CR>",
		desc = "Toggle Terminal (ToggleTerm)",
	},
}, { mode = "n" })

-- insert keymap
wk.add({
	{
		"<A-;>",
		function()
			require("Comment.api").toggle.linewise.current()
		end,
		desc = "Toggle Comment (Comment.nvim)",
		remap = false,
	},
}, { mode = { "n", "i", "v" } })
