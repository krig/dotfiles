return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>t", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<leader>n", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
      { "<leader>\"", "<cmd>Telescope registers<cr>", desc = "Grep" },
      { "<leader>ss", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
      { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
      { "<leader>gb", "<cmd>Telescope git_bcommits<cr>", desc = "Git Buffer Commits" },
      { "<leader>gt", "<cmd>Telescope git_branches<cr>", desc = "Git Branches" },
      { "<leader>sw", "<cmd>Telescope grep_string word_match=-w<cr>", desc = "Grep Word" },
    },
  },
}
