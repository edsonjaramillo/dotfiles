local M = {}

-- Add this to your init.lua or init.vim (wrapped in lua << EOF ... EOF)
M.debugUnderCursor = function()
	-- Get the word under cursor
	local word = vim.fn.expand("<cword>")
	local filetype = vim.bo.filetype
	local debug_line = ""

	-- Modular filetype-based debug statements
	if filetype == "python" then
		debug_line = string.format('print(f"{%s=}")', word)
	elseif
		filetype == "javascript"
		or filetype == "typescript"
		or filetype == "javascriptreact"
		or filetype == "typescriptreact"
	then
		debug_line = string.format('console.log("%s:", %s);', word, word)
	elseif filetype == "go" then
		debug_line = string.format('fmt.Printf("%%s: %%+v\\n", "%s", %s)', word, word)
	elseif filetype == "lua" then
		debug_line = string.format('print("%s:", vim.inspect(%s))', word, word)
		-- Fallback for unknown filetypes
		debug_line = string.format("// DEBUG: %s", word)
	end

	-- Get current line number and insert below
	local current_line = vim.fn.line(".")
	local indent = vim.fn.indent(current_line)
	local indent_str = string.rep(" ", indent)

	-- Insert the debug line below current line
	vim.fn.append(current_line, indent_str .. debug_line)

	-- Move cursor to the new line
	vim.cmd("normal! j")
end

return M
