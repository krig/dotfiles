return {
  {
    "folke/which-key.nvim",
    enabled = false,
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
      defaults = {},
      icons = { mappings = false },
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>b", group = "buffer" },
          { "<leader>c", group = "code" },
          { "<leader>f", group = "file" },
          { "<leader>g", group = "git" },
          { "<leader>q", group = "quit" },
          { "<leader>s", group = "search" },
          { "<leader>t", group = "terminal" },
          { "<leader>u", group = "undo" },
          { "<leader>x", group = "trouble" },
          {
            "<leader>w",
            group = "windows",
            proxy = "<c-w>",
          },
        },
      },
    },
  }
}
