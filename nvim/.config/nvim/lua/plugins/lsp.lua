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
                eslint = {
                    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
                    settings = {
                        rulesCustomizations = {
                            { rule = "style/*", severity = "off", fixable = true },
                            { rule = "format/*", severity = "off", fixable = true },
                            { rule = "*-indent", severity = "off", fixable = true },
                            { rule = "*-spacing", severity = "off", fixable = true },
                            { rule = "*-spaces", severity = "off", fixable = true },
                            { rule = "*-order", severity = "off", fixable = true },
                            { rule = "*-dangle", severity = "off", fixable = true },
                            { rule = "*-newline", severity = "off", fixable = true },
                            { rule = "*quotes", severity = "off", fixable = true },
                            { rule = "*semi", severity = "off", fixable = true },
                        },
                    },
                },
            },
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup()
            -- Enable virtual text for diagnostics
            vim.diagnostic.config({ virtual_text = true })
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
                    -- node
                    "ts_ls",
                    "eslint",
                    -- "eslint_d",
                    "prettier",
                    -- python
                    "pyright",
                    "ruff",
                    -- json
                    "jsonls",
                    -- toml
                    "tombi",
                },
            })
        end,
    },
    -- syntax highlighting
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
                "bash",
                "javascript",
                "tsx",
                "typescript",
                "python",
                "tmux",
                "toml",
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}
