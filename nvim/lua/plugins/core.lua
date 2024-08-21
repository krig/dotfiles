-- Using this to add small plugins instead of
-- creating a separate file for each one.

-- get project-relative path of buffer
local function relpath()
  local fname = vim.api.nvim_buf_get_name(0)
  local pname = string.gsub(fname, vim.loop.cwd(), '@')
  if pname:sub(1, #'@') == '@' then
    return pname
  end
  pname = string.gsub(fname, vim.env.HOME, '~')
  if pname ~= '' then
    return pname
  end
  pname = vim.fn.expand('%')
  if pname ~= '' then
    return pname
  end
  return '[no name]'
end

return {
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
    "mbbill/undotree",
    lazy = false,
    keys = {
      { "<leader>ut", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" },
    },
  },
  {
    "tpope/vim-fugitive",
    lazy = true,
    cmd = { "Git", "G" },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
      on_attach = function(buffer)
        local gitsigns = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- Navigation
        map('n', ']h', function()
          if vim.wo.diff then
            vim.cmd.normal({']c', bang = true})
          else
            gitsigns.nav_hunk('next')
          end
        end, "Next hunk")

        map('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal({'[c', bang = true})
          else
            gitsigns.nav_hunk('prev')
          end
        end, "Prev hunk")

        -- Actions
        map('n', '<leader>hs', gitsigns.stage_hunk, "Stage hunk")
        map('n', '<leader>hr', gitsigns.reset_hunk, "Reset hunk")
        map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map('n', '<leader>hS', gitsigns.stage_buffer, "Stage buffer")
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, "Stage hunk")
        map('n', '<leader>hR', gitsigns.reset_buffer, "Reset buffer")
        map('n', '<leader>hp', gitsigns.preview_hunk, "Preview hunk")
        map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end, "Blame line")
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, "Toggle line blame")
        map('n', '<leader>hd', gitsigns.diffthis, "Diff this")
        map('n', '<leader>hD', function() gitsigns.diffthis('~') end, "Diff this ~")
        map('n', '<leader>td', gitsigns.toggle_deleted, "Toggle deleted")

        -- Text object
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end
    },
  },
  {
    "tpope/vim-sleuth",
  },
  {
    "jeffkreeftmeijer/vim-numbertoggle",
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = false,
        theme = "auto",
        globalstatus = true,
        section_separators = '',
        component_separators = '',
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'searchcount', 'selectioncount'},
        lualine_c = {relpath},
        lualine_x = {},
        lualine_y = {'diagnostics'},
        lualine_z = {'branch'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
    },
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
      open_mapping = "<leader>tt",
      insert_mappings =false,
    },
    keys = {
      { "<leader>tt", desc = "Open terminal" },
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
        javascript = { "prettierd", "prettier", stop_after_first = true },
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
  }
}
