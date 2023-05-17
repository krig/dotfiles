-- Using this to add small plugins instead of
-- creating a separate file for each one.
return {
  {
    "johnfrankmorgan/whitespace.nvim",
    keys = {
      {
        "<leader>ww",
        function()
          require("whitespace-nvim").trim()
        end,
        desc = "Trim trailing whitespace",
      },
    },
  },
  {
    "mbbill/undotree",
    lazy = false,
    keys = {
      { "<leader>ut", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" },
    },
  },
  {
    "petertriho/nvim-scrollbar",
  },
  {
    "tpope/vim-eunuch",
  },
  {
    "tpope/vim-fugitive",
  },
  {
    "tpope/vim-rhubarb",
  },
  {
    "tpope/vim-sleuth",
  },
  {
    "jeffkreeftmeijer/vim-numbertoggle",
  },
}
