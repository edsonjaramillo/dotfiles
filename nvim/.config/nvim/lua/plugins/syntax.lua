return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "vim",
                "vimdoc",
                "lua",
                "bash",
                "javascript",
                "tsx",
                "typescript",
                "python",
                "tmux",
                "toml",
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    {
        "artemave/workspace-diagnostics.nvim",
    },
}
