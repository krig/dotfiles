return {
  {
    "catppuccin/nvim",
    enabled = false,
    lazy = false,
    name = "catppuccin",
    opts = {
      flavour = "frappe",
      styles = {
        conditionals = { "bold" },
      },
    },
    init = function() vim.cmd.colorscheme 'catppuccin' end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    init = function() vim.cmd.colorscheme 'kanagawa-wave' end,
  },
}
