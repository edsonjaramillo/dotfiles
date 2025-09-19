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
            },
        },
        config = function(_, opts)
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "bashls" },
            })

            -- Enable virtual text for diagnostics
            vim.diagnostic.config({ virtual_text = true })

            -- keymaps
            -- vim.api.nvim_create_autocmd(
            --     "LspAttach",
            --     { --  Use LspAttach autocommand to only map the following keys after the language server attaches to the current buffer
            --         -- group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            --         callback = function(ev)
            --             vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc" -- Enable completion triggered by <c-x><c-o>

            --             -- Buffer local mappings.
            --             -- See `:help vim.lsp.*` for documentation on any of the below functions
            --             local opts = { buffer = ev.buf }
            --             -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            --             -- vim.keymap.set("n", "<leader><space>", vim.lsp.buf.hover, opts)
            --             -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            --             -- vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
            --             -- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            --             -- vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
            --             -- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

            --             -- vim.keymap.set("n", "<leader>f", function()
            --             --     vim.lsp.buf.format({ async = true })
            --             -- end, opts)

            --             -- -- Open the diagnostic under the cursor in a float window
            --             -- vim.keymap.set("n", "<leader>d", function()
            --             --     vim.diagnostic.open_float({
            --             --         border = "rounded",
            --             --     })
            --             -- end, opts)
            --         end,
            --     }
            -- )
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = { "vim", "vimdoc", "lua", "bash" },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}
