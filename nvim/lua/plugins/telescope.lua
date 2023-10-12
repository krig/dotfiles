return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      pickers = {
        fd = {
          theme = "ivy",
        },
        find_files = {
          theme = "ivy",
        },
        git_files = {
          theme = "ivy",
        },
        oldfiles = {
          theme = "ivy",
        },
      },
    },
    keys = {
      { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader><space>", "<cmd>Telescope fd<cr>", desc = "Find Files" },
      { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
      { "<leader>fF", function() require('lazyvim.util').telescope("files") end, desc = "Find Files (lazy root)" },
      { "<leader>ff", function() require('lazyvim.util').telescope("files", { cwd = false }) end, desc = "Find Files (cwd)" },
      { "<leader>sw", "<cmd>Telescope grep_string word_match=-w<cr>", desc = "Grep Word" },
    },
  },
}
