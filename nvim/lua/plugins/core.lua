-- Using this to add small plugins instead of
-- creating a separate file for each one.
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
    cmd = "Git",
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
          icons_enabled = false,
          theme = "auto",
          globalstatus = true,
          section_separators = '',
          component_separators = '',
        },
      }
    end,
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
}
