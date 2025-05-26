return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = 'false',
    build = ":TSUpdate",
    config = function()
      require'nvim-treesitter'.install {
        "bash",
        "c",
        "css",
        "dockerfile",
        "lua",
        "markdown",
        "markdown_inline",
        "odin",
        "python",
        "query",
        "roc",
        "sql",
        "superhtml",
        "typescript",
        "vim",
        "vimdoc",
        "zig",
      }
    end,
  },
}
