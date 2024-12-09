-- Using this to add small plugins instead of
-- creating a separate file for each one.

return {
  {
    "echasnovski/mini.nvim",
    version = '*',
    config = function()
      require('mini.ai').setup()
      require('mini.bracketed').setup()
      require('mini.bufremove').setup()
      require('mini.git').setup()
      require('mini.icons').setup()
      require('mini.jump2d').setup()
      require('mini.notify').setup()
      require('mini.operators').setup()
      require('mini.starter').setup()
      require('mini.statusline').setup()
      require('mini.surround').setup()
      require('mini.trailspace').setup()
      vim.keymap.set('n', '<leader>cw', function()
        MiniTrailspace.trim()
        MiniTrailspace.trim_last_lines()
      end, { desc = "Trim whitespace" })
      local clue = require('mini.clue')
      clue.setup({
        triggers = {
          -- Leader triggers
          { mode = 'n', keys = '<Leader>' },
          { mode = 'x', keys = '<Leader>' },

          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },

          -- `g` key
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },

          -- Marks
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },

          -- Registers
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },

          -- Window commands
          { mode = 'n', keys = '<C-w>' },

          -- `z` key
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },
        },
        clues = {
          clue.gen_clues.builtin_completion(),
          clue.gen_clues.g(),
          clue.gen_clues.marks(),
          clue.gen_clues.registers(),
          clue.gen_clues.windows(),
          clue.gen_clues.z(),
        },
      })
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      bufdelete = { enabled = true },
      dashboard = { enabled = false },
      dim = { enabled = true },
      git = { enabled = false },
      gitbrowse = { enabled = false },
      indent = { enabled = true },
      input = { enabled = true },
      lazygit = { enabled = false },
      notifier = { enabled = false },
      notify = { enabled = false },
      quickfile = { enabled = true },
      rename = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      terminal = { enabled = false },
      toggle = { enabled = false },
      words = { enabled = false },
      zen = { enabled = true },
    },
    keys = {
      { "<leader>oz",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
    { "<leader>ow",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    },
  },
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
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = {
          "bash",
          "c",
          "css",
          "dockerfile",
          "lua",
          "markdown",
          "markdown_inline",
          "odin",
          "python",
          "query",
          "roc",
          "sql",
          "superhtml",
          "typescript",
          "vim",
          "vimdoc",
          "zig",
        },
        modules = {},
        sync_install = false,
        ignore_install = {},
        auto_install = false,

        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local lsp = require('lspconfig')
      lsp.bacon_ls.setup {}
      lsp.janet_lsp.setup {}
      lsp.lua_ls.setup {}
      lsp.ols.setup {}
      -- lsp.denols.setup {}
      lsp.eslint.setup {}
      lsp.pyright.setup {}
      lsp.rust_analyzer.setup {}
      lsp.superhtml.setup {}
      lsp.zls.setup {}

      local keys = {
        { "<leader>cf", vim.lsp.buf.format, desc = "Format buffer" },
        { "<leader>cD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
        { "<leader>kk", vim.lsp.buf.hover, desc = "Hover" },
        { "<leader>kh", vim.lsp.buf.signature_help, desc = "Signature Help" },
        { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help" },
        { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
        { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
      }
      for _, key in ipairs(keys) do
        vim.keymap.set("n", key[1], key[2], { desc = key["desc"] })
      end
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    ft = { "javascript", "typescript", "typescriptreact" },
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
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
