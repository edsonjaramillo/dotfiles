local M = {}

-- Directory names to exclude from searches/file pickers.
M.folder_exclude = { "node_modules", ".git", "dist" }

-- A set containing the current working directory. Used to "prioritize" the cwd in
-- other parts of the configuration (e.g., sorter hints). The key name keeps the
-- original typo for backwards compatibility.
M.priotize_cwd = { [vim.fn.getcwd()] = true }

return M
