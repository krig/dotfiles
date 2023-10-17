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
    "f-person/git-blame.nvim",
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
        use_libuv_file_watcher = true,
        components = {
          harpoon_index = function(config, node, _)
            local ok, Marked = pcall(require, 'harpoon.mark')
            if ok then
              local path = node:get_id()
              local ok2, index = pcall(Marked.get_index_of, path)
              if ok2 and index and index > 0 then
                return {
                  text = string.format(" ⇁%d", index),
                  highlight = config.highlight or "NeoTreeDirectoryIcon",
                }
              end
            end
            return {}
          end
        },
        renderers = {
          file = {
            {"name", use_git_status_colors = true},
            {"harpoon_index"},
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
}
