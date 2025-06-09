return {
  {
    "rose-pine/neovim",
    enabled = true,
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = 'dark'
      vim.cmd.colorscheme 'rose-pine'
    end
  },
  {
    'datsfilipe/vesper.nvim',
    lazy = false,
    enabled = false,
    priority = 1000,
    config = function()
      vim.o.background = 'dark'
      vim.cmd.colorscheme 'vesper'
    end
  },
  {
    "savq/melange-nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      vim.cmd.colorscheme 'melange'
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    enabled = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true,    -- invert background for search, diffs, statuslines and errors
        contrast = "hard", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
      })
      vim.o.background = 'dark'
      vim.cmd.colorscheme 'gruvbox'
    end,
  },
}
