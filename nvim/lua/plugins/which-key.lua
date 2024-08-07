return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
      icons = { mappings = false },
      defaults = {},
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>c", group = "code" },
          { "<leader>f", group = "file" },
          { "<leader>g", group = "git" },
          { "<leader>q", group = "quit" },
          { "<leader>s", group = "search" },
          { "<leader>u", group = "ui", icon = { color = "cyan" } },
          { "<leader>x", group = "diagnostics/quickfix", icon = { color = "green" } },
          {
            "<leader>b",
            group = "buffer",
            expand = function()
              return require("which-key.extras").expand.buf()
            end,
          },
          {
            "<leader>w",
            group = "windows",
            proxy = "<c-w>",
            expand = function()
              return require("which-key.extras").expand.win()
            end,
          },
          -- better descriptions
          { "gx", desc = "Open with system app" },
        },
      },
    },
  }
}
