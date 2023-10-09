local Util = require("lazyvim.util")

return {
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzy-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzy_native")
        require("lazyvim.util").root_patterns = { ".git" }
      end,
      keys = {
        { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
        { "<leader><space>", "<cmd>Telescope fd<cr>", desc = "Find Files" },
        { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
        { "<leader>fF", Util.telescope("files"), desc = "Find Files (lazy root)" },
        { "<leader>ff", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
        { "<leader>sw", "<cmd>Telescope grep_string word_match=-w<cr>", desc = "Grep Word" },
      },
    },
  },
}
