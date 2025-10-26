---@class LazyDevPlugin
---@field default string
---@field provider blink.cmp.SourceProviderConfigPartial

---@type LazyDevPlugin
local lazyDevPlugin = {
	default = "lazydev",
	provider = {
		name = "LazyDev",
		module = "lazydev.integrations.blink",
		score_offset = 100,
	},
}

---@type LazyDevPlugin
local npmPlugin = {
	default = "npm",
	provider = {
		name = "npm",
		module = "blink-cmp-npm",
		score_offset = 100,
		opts = {
			only_latest_version = true,
		},
		should_show_items = function()
			return vim.fn.expand("%:t") == "package.json"
		end,
	},
}

---@type LazyDevPlugin
local copilotPlugin = {
	default = "copilot",
	provider = {
		name = "copilot",
		module = "blink-copilot",
		score_offset = 100,
		async = true,
	},
}

---@module 'lazy'
---@type LazySpec[]
return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{ -- optional blink completion source for require statements and module annotations
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"alexandre-abrioux/blink-cmp-npm.nvim",
			{
				"L3MON4D3/LuaSnip",
				tag = "v2.4.0",
				run = "make install_jsregexp",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
			"fang2hou/blink-copilot",
		},
		version = "1.*",
		---@module 'blink-cmp'
		---@type blink.cmp.Config
		opts = {
			sources = {
				default = {
					copilotPlugin.default,
					lazyDevPlugin.default,
					npmPlugin.default,
					"lsp",
					"path",
					"snippets",
					"buffer",
				},
				providers = {
					lazydev = lazyDevPlugin.provider,
					npm = npmPlugin.provider,
					copilot = copilotPlugin.provider,
				},
			},
			completion = {
				documentation = { auto_show = true },
				list = { selection = { preselect = false } },
			},
			keymap = {
				preset = "default",
				["<CR>"] = { "accept", "fallback" },
				["<C><leader>"] = { "show" },
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
				["<UP>"] = { "fallback" },
				["<DOWN>"] = { "fallback" },
			},
			appearance = {
				nerd_font_variant = "mono",
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
