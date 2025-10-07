local M = {}

-- Detect whether the current working directory is the user's dotfiles repo.
M.is_dotfiles = vim.fn.getcwd() == vim.fn.expand("~") .. "/dotfiles"

return M
