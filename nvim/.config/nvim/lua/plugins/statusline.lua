return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local earthshine_lualine_theme = require("lualine.themes.earthshine")
        require("lualine").setup({
            options = {
                theme = earthshine_lualine_theme,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff" },
                lualine_c = { "diagnostics" },
                lualine_x = { "filename", "encoding", "fileformat", "filetype", "lsp_status" },
                lualine_y = { "windows" },
            },
        })
    end,
}
