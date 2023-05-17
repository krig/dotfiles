return {
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>m",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        desc = "Harpoon: Quick menu",
      },
      {
        "<leader>n",
        function()
          require("harpoon.mark").add_file()
        end,
        desc = "Harpoon: Mark file",
      },
      {
        "<leader>1",
        function()
          require("harpoon.ui").nav_file(1)
        end,
        desc = "Jump to file 1",
      },
      {
        "<leader>2",
        function()
          require("harpoon.ui").nav_file(2)
        end,
        desc = "Jump to file 2",
      },
      {
        "<leader>3",
        function()
          require("harpoon.ui").nav_file(3)
        end,
        desc = "Jump to file 3",
      },
      {
        "<leader>4",
        function()
          require("harpoon.ui").nav_file(4)
        end,
        desc = "Jump to file 4",
      },
    },
  },
}
