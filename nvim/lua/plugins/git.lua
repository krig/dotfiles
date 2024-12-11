return {
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
            vim.cmd.normal({ ']c', bang = true })
          else
            gitsigns.nav_hunk('next')
          end
        end, "Next hunk")

        map('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
          else
            gitsigns.nav_hunk('prev')
          end
        end, "Prev hunk")

        map('n', '<leader>gl', gitsigns.toggle_current_line_blame, "Toggle line blame")
        map('n', '<leader>gd', gitsigns.diffthis, "Diff this")
        map('n', '<leader>gD', function() gitsigns.diffthis('~') end, "Diff this ~")
        map('n', '<leader>gx', gitsigns.toggle_deleted, "Toggle deleted")
      end
    },
  },
}
