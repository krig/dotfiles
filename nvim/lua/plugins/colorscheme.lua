return {
  -- {
  --   "catppuccin/nvim",
  --   lazy = false,
  --   name = "catppuccin",
  --   opts = {
  --     flavour = "frappe",
  --     styles = {
  --       conditionals = { "bold" },
  --     },
  --   },
  -- },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}
