-- Ensure_installed language servers
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "bashls" },
})

-- Enable virtual text for diagnostics
vim.diagnostic.config({ virtual_text = true })
