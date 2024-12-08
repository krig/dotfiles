-- Using this to add small plugins instead of
-- creating a separate file for each one.

return {
  {
    "echasnovski/mini.nvim",
    version = '*',
    config = function()
      require('mini.statusline').setup()
      require('mini.ai').setup()
      require('mini.git').setup()
    end,
  },
  {
    "tpope/vim-sleuth",
  },
  {
    'numToStr/Comment.nvim',
    opts = {
    },
  },
  {
    'stevearc/dressing.nvim',
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
    "johnfrankmorgan/whitespace.nvim",
    keys = {
      {
        "<leader>cw",
        function()
          require("whitespace-nvim").trim()
        end,
        desc = "Trim trailing whitespace",
      },
    },
  },
  {
    'stevearc/conform.nvim',
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports", "gofmt" },
        rust = { "rustfmt", lsp_format = "fallback" },
        python = { "isort", "black" },
        javascript = { "prettier" },
        markdown = { "prettier" },
      },
      default_format_opts = {
        lsp_format = "fallback",
      },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" },
        },
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require'nvim-treesitter.configs'.setup {
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
      lsp.bacon_ls.setup{}
      lsp.janet_lsp.setup{}
      lsp.lua_ls.setup{}
      lsp.ts_ls.setup{}
      lsp.ols.setup{}
      lsp.pyright.setup{}
      lsp.rust_analyzer.setup{}
      lsp.superhtml.setup{}
      lsp.zls.setup{}
    end,
  },
}
