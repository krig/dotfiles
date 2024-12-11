return {
  {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
    },
    config = function()
      local t = require('telescope')
      t.setup({
        defaults = {
          layout_strategy = 'bottom_pane',
          layout_config = {
            height = 0.75,
            prompt_position = 'bottom',
          },
        },
        extensions = {
          fzf = {},
        },
      })
      t.load_extension('fzf')

      require("krig.multigrep").setup()
    end,
    keys = {
      { "<leader>ld",       "<cmd>Telescope lsp_definitions<cr>",           desc = "Goto Definition" },
      { "<leader>lr",       "<cmd>Telescope lsp_references<cr>",            desc = "References" },
      { "<leader>li",       "<cmd>Telescope lsp_implementations<cr>",       desc = "Implementations" },
      { "<leader>lt",       "<cmd>Telescope lsp_type_definitions<cr>",      desc = "Goto Type Definition" },
      { "<leader>.",        "<cmd>Telescope buffers<cr>",                   desc = "Buffers" },
      { "<leader>ht",       "<cmd>Telescope help_tags<cr>",                 desc = "Help" },
      { "<leader>cc",       "<cmd>Telescope commands<cr>",                  desc = "Commands" },
      { "<leader>fr",       "<cmd>Telescope oldfiles<cr>",                  desc = "Recent Files" },
      { "<leader>sb",       "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy Find" },
      { "<leader>ss",       "<cmd>Telescope live_grep<cr>",                 desc = "Live Grep" },
      { "<leader>v",        "<cmd>Telescope live_grep<cr>",                 desc = "Live Grep" },
      { "<leader>sh",       "<cmd>Telescope search_history<cr>",            desc = "Search History" },
      { "<leader>sp",       "<cmd>Telescope registers<cr>",                 desc = "Registers" },
      { "<leader><leader>", "<cmd>Telescope find_files<cr>",                desc = "Find Files" },
      { "<leader>fg",       "<cmd>Telescope git_files<cr>",                 desc = "Git Files" },
      { "<leader>gb",       "<cmd>Telescope git_bcommits<cr>",              desc = "Git Buffer Commits" },
      { "<leader>gt",       "<cmd>Telescope git_branches<cr>",              desc = "Git Branches" },
      { "<leader>sw",       "<cmd>Telescope grep_string word_match=-w<cr>", desc = "Grep Word" },
      {
        "<leader>fd",
        function()
          require("krig.multigrep").multigrep()
        end,
        { desc = "Multigrep" },
      },
      {
        "<leader>og",
        function()
          require('telescope.builtin').live_grep {
            grep_open_files = true,
            prompt_title = "Grep open files",
          }
        end,
        desc = "Grep open files"
      },
      {
        "<leader>ob",
        function()
          local builtin = require('telescope.builtin')
          local utils = require('telescope.utils')
          builtin.find_files({ cwd = utils.buffer_dir() })
        end,
        desc = "Find files from current buffer"
      },
      {
        "<leader>r",
        function()
          local builtin = require('telescope.builtin')
          builtin.resume()
        end,
        desc = "Resume last telescope buffer"
      },
      {
        "<leader>fp",
        function()
          local builtin = require('telescope.builtin')
          builtin.find_files {
            cwd = vim.fn.stdpath("data") .. "/lazy",
          }
        end,
        desc = "Find file in lazy plugin"
      },
      {
        "<leader>fc",
        function()
          local builtin = require('telescope.builtin')
          builtin.find_files {
            cwd = vim.fn.stdpath("config"),
          }
        end,
        desc = "Find file in nvim config"
      },
    },
  },
}
