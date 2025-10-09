---@module 'lazy'
---@type LazySpec[]
return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"vim",
				"vimdoc",
				"lua",
				-- shell
				"bash",
				-- web
				"css",
				"html",
				"javascript",
				"typescript",
				"tsx",
				-- programming
				"python",
				-- config
				"json",
				"jsonc",
				"markdown",
				"toml",
				"tmux",
				"yaml",
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"artemave/workspace-diagnostics.nvim",
	},
}
