-- ccreate a keeymao that if jk is pressed in insert mode it exits to normal mode
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })