return {
	-- lspconfig
	{
		"mason-org/mason.nvim",
		build = ":MasonUpdate",
		opts = {},
		config = function()
			require("mason").setup()
			-- Enable virtual text for diagnostics
			vim.diagnostic.config({ virtual_text = true })
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- lua
					"lua-language-server",
					"stylua",
					-- bash
					"bash-language-server",
					"shfmt",
					-- "shellcheck",
					-- node
					-- "ts_ls",
					-- "eslint",
					-- "prettier",
					-- python
					-- "pyright",
					-- "ruff",
					-- json
					-- "jsonls",
					-- toml
					-- "tombi",
				},
			})
		end,
	},
}
