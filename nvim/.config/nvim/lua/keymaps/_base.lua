local esc_keys = { "jk", "kj" }

-- esc keys shjortcut to exit insert/visual modes
for _, key in ipairs(esc_keys) do
    vim.keymap.set({ "i", "v", "x" }, key, "<Esc>", {
        noremap = true,
        silent = true,
        desc = "Exit to Normal mode",
    })
end
