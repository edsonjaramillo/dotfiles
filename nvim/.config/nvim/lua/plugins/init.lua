local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- { import = "plugins.core" },
    -- { import = "plugins.editing" },
    -- { import = "plugins.git" },
    { import = "plugins.completion" },
    { import = "plugins.flash" },
    { import = "plugins.formatting" },
    { import = "plugins.lsp" },
    { import = "plugins.snacks" },
    { import = "plugins.treesitter" },
    -- { import = "plugins.statusline" },
    -- { import = "plugins.debugger" },
    -- { import = "plugins.extras" },
  },
  defaults = { lazy = true },
--   install = { colorscheme = { "tokyonight", "catppuccin" } },
  checker = { enabled = true }, -- optional: plugin update checker
--   performance = { rtp = { disabled_plugins = { "netrwPlugin" } } },
})