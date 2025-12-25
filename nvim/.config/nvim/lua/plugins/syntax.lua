---@module 'lazy'
---@type LazySpec[]
return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			textobjects = {
				select = {
					enable = true,
					keymaps = {
						["aA"] = "@assignment.lhs",
						["aa"] = "@assignment.rhs",
						["iA"] = "@assignment.lhs",
						["ia"] = "@assignment.rhs",
						["ac"] = "@comment.outer",
						["ic"] = "@comment.inner",
						["ii"] = "@conditional.inner",
						["ai"] = "@conditional.outer",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["al"] = "@loop.outer",
						["il"] = "@loop.inner",
						["ar"] = "@return.outer",
						["ir"] = "@return.inner",
					},
				},
			},
			ensure_installed = {
				"vim",
				"vimdoc",
				"nix",
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
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "master",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
