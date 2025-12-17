local M = {}

-- Detect whether the current working directory is the user's dotfiles repo.
M.is_dotfiles = function()
	return vim.fn.getcwd() == vim.fn.expand("~") .. "/dotfiles"
end

return M
