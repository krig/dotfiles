-- Using this to add small plugins instead of
-- creating a separate file for each one.
return {
  {
    "johnfrankmorgan/whitespace.nvim",
    keys = {
      {
        "<leader>ww",
        function()
          require("whitespace-nvim").trim()
        end,
        desc = "Trim trailing whitespace",
      },
    },
  },
  {
    "mbbill/undotree",
    lazy = false,
    keys = {
      { "<leader>ut", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" },
    },
  },
  {
    "tpope/vim-fugitive",
    cmd = "Git",
  },
  {
    "tpope/vim-sleuth",
  },
  {
    "jeffkreeftmeijer/vim-numbertoggle",
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        renderers = {
          file = {
            {"name", use_git_status_colors = true},
            {"diagnostics"},
            {"git_status", highlight = "NeoTreeDimText"},
          },
        },
      },
      default_component_configs = {
        indent = {
          with_markers = false,
        },
        git_status = {
          symbols = false,
        }
      },
    },
    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree",
      },
    },
  },
  {
    "ChrisWellsWood/roc.vim",
    ft = { "roc" },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function ()
      return {
        options = {
          theme = "auto",
          globalstatus = true,
        },
      }
    end,
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
      open_mapping = "<leader>t",
      insert_mappings =false,
    },
    keys = {
      { "<leader>t" },
    },
  },
  {
    'ziglang/zig.vim',
    version = '*',
    ft = { "zig" },
    init = function ()
      vim.g.zig_fmt_autosave = 0
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      document_highlight = { enabled = false },
      codelens = { enabled = false },
    },
  },
}
