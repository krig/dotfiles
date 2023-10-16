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
        live_grep = {
          theme = "ivy",
        },
        grep_string = {
          theme = "ivy",
        },
      },
    },
    keys = {
      { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
      { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
      { "<leader>ss", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
      { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
      { "<leader>sw", "<cmd>Telescope grep_string word_match=-w<cr>", desc = "Grep Word" },
    },
  },
}
