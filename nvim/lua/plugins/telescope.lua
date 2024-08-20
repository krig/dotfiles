return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<leader>ss", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>sh", "<cmd>Telescope search_history<cr>", desc = "Search History" },
      { "<leader>sr", "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader><leader>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
      { "<leader>gb", "<cmd>Telescope git_bcommits<cr>", desc = "Git Buffer Commits" },
      { "<leader>gt", "<cmd>Telescope git_branches<cr>", desc = "Git Branches" },
      { "<leader>sw", "<cmd>Telescope grep_string word_match=-w<cr>", desc = "Grep Word" },
      { "<leader>sf", function ()
        require('telescope.builtin').live_grep {
          grep_open_files = true,
          prompt_title = "Grep open files",
        }
      end, desc = "Grep open files" },
      { "<leader>d", function()
        local builtin = require('telescope.builtin')
        local utils = require('telescope.utils')
        builtin.find_files({ cwd = utils.buffer_dir() })
      end, desc = "Find files from current buffer" },
      { "<leader>r", function()
        local builtin = require('telescope.builtin')
        builtin.resume()
      end, desc = "Resume last telescope buffer" },
    },
  },
}
