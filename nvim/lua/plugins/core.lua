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
    "petertriho/nvim-scrollbar",
  },
  {
    "tpope/vim-eunuch",
  },
  {
    "tpope/vim-fugitive",
  },
  {
    "tpope/vim-rhubarb",
  },
  {
    "tpope/vim-sleuth",
  },
  {
    "jeffkreeftmeijer/vim-numbertoggle",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "typescript", "tsx" })
      end
    end,
  },
  {
    'f-person/git-blame.nvim',
  },
  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    config = function(_, opts)
      require("project_nvim").setup(opts)
      require("telescope").load_extension("projects")
    end,
    opts = {
      detection_methods = { "pattern" },
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn" },
      silent_chdir = false,
    },
    keys = {
      { "<leader>fp", "<Cmd>Telescope projects<CR>", desc = "Projects" },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        bind_to_cwd = true,
        use_libuv_file_watcher = false,
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
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root() })
        end,
        desc = "Explorer NeoTree (lazy root)",
      },
    }
  }
}
