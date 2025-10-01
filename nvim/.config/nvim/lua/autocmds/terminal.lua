local esc_keys = { "jk", "kj" }
local function set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	for _, key in ipairs(esc_keys) do
		vim.keymap.set("t", key, [[<C-\><C-n>]], opts)
	end
end

-- when entering a terminal, set the keymaps
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = [[term://*]],
	callback = set_terminal_keymaps,
})

-- remove line numbers in terminals
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = [[term://*]],
	callback = function()
		vim.wo.number = false
		vim.wo.relativenumber = false
		vim.wo.signcolumn = "no"
	end,
})

-- start terminal in insert mode
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = [[term://*]],
	callback = function()
		vim.cmd.startinsert()
	end,
})
