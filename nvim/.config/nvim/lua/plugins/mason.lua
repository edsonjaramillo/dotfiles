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
					-- bash
					"bashls",
					"shfmt",
					-- node
					"ts_ls",
					"eslint",
					"prettier",
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
