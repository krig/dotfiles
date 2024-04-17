return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>t", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<leader>n", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
      { "<leader>ss", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
      { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
      { "<leader>sw", "<cmd>Telescope grep_string word_match=-w<cr>", desc = "Grep Word" },
    },
  },
}
