return {
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzy-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzy_native")
      end,
    },
  },
}
