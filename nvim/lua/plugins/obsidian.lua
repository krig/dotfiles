return {
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  event = {
    "BufReadPre " .. vim.fn.expand "~" .. "/Documents/*.md",
    "BufNewFile " .. vim.fn.expand "~" .. "/Documents/*.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "Daily",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y-%m-%d",
    },
    completion = {
      nvim_cmp = false,
    },
  },
}
