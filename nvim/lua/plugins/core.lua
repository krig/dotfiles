-- Using this to add small plugins instead of
-- creating a separate file for each one.

return {
  {
    'brenoprata10/nvim-highlight-colors',
    opts = {
    },
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    event = "VeryLazy",
    opts = {
      keymaps = {
        useDefaults = true,
      }
    },
  },
}
