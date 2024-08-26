return {
  {
    "tpope/vim-fugitive",
    lazy = true,
    cmd = { "Git", "G" },
    keys = {
      { "<leader>gg", "<cmd>Git<cr>", desc = "Fugitive" },
    },
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
}
