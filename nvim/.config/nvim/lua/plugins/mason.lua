---@module 'lazy'
---@type LazySpec[]
return {
	-- lspconfig
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- lua
					"lua_ls",
					"stylua",
					-- copilot
					"copilot",
					-- bash
					"bashls",
					"shfmt",
					-- node
					"ts_ls",
					"eslint",
					"emmet_ls",
					"prettier",
					-- css
					"tailwindcss",
					"cssls",
					-- python
					-- "pyright",
					-- "ruff",
					-- json
					"jsonls",
					-- toml
					"taplo",
					--yaml
					"yamlls",
					"yamlfmt",
				},
			})
		end,
	},
}
