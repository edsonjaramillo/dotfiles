return {
    -- lspconfig
    {
        "mason-org/mason.nvim",
        build = ":MasonUpdate",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            "artemave/workspace-diagnostics.nvim",
        },
        opts = {
            servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            version = "LuaJIT",
                            workspace = {
                                library = vim.api.nvim_get_runtime_file("", true),
                            },
                            telemetry = {
                                enable = false,
                            },
                        },
                    },
                },
                bashls = {},
                tombi = {}
            },
        },
        config = function(_, opts)
            require("mason").setup()
            require("mason-lspconfig").setup()
            -- Enable virtual text for diagnostics
            vim.diagnostic.config({ virtual_text = true })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = { "vim", "vimdoc", "lua", "bash", "toml" },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "mason.nvim", "mason-lspconfig.nvim" },
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    -- lua
                    "lua_ls",
                    "stylua",
                    -- bash
                    "bashls",
                    "shfmt",
                    "shellcheck",
                    -- toml
                    "tombi"
                },
            })
        end,
    },
}
