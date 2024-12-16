-- Using this to add small plugins instead of
-- creating a separate file for each one.

return {
  {
    'brenoprata10/nvim-highlight-colors',
    opts = {
    },
  },
  {
    "smjonas/inc-rename.nvim",
    opts = {
    },
    keys = {
      {
        "<leader>ci",
        function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end,
        desc = "IncRename",
        expr = true,
      },
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
