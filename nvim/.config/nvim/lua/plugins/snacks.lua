return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    picker = { enabled = true },
  },
  keys = {
    {
      "<leader>bb",
      function()
        Snacks.picker.buffers({
          win = {
            input = {
              keys = {
                ["<c-d>"] = { "bufdelete", mode = { "n", "i" } },
              },
            },
          }
        })
      end,
      desc = "Delete Buffers"
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files({
          win = {
            input = {
              keys = {
                ["<c-h>"] = { "split", mode = { "n", "i" } },
                ["<c-v>"] = { "vsplit", mode = { "n", "i" } },
              },
            },
          }
        })
      end,
      desc = "Find Files"
    },
    { "<leader>w",  function() Snacks.bufdelete() end,      desc = "Delete Buffer" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
  },

}
