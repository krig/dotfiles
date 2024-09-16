return {
  {
    "catppuccin/nvim",
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
}
