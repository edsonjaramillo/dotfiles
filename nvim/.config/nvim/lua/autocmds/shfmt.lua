local notify = require("notify")

-- Auto-format sh/bash files with shfmt on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.sh,*.bash",
    callback = function()
        local filetype = vim.bo.filetype
        if filetype ~= "sh" and filetype ~= "bash" then
            notify("Not a sh/bash file; skipping formatting", "warn", { title = "shfmt" })
            return
        end
        if vim.fn.executable("shfmt") == 0 then
            -- shfmt not installed; skip
            notify("shfmt not found in PATH; skipping formatting", "warn", { title = "shfmt" })
            return
        end
        local filename = vim.fn.expand("%:p")
        local escaped = vim.fn.shellescape(filename, true)
        -- Use shfmt as a filter: %!shfmt -filename <file>
        -- keepjumps/keepmarks avoids jumping the cursor unnecessarily
        vim.cmd(("silent keepjumps keepmarks %%!shfmt -filename %s"):format(escaped))
        notify("Formatted with shfmt", "info", { title = "shfmt", timeout = 500 })
    end,
})
