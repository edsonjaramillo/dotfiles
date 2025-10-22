local function set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
end

-- when entering a terminal, set the keymaps
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = [[term://*]],
	callback = set_terminal_keymaps,
})
