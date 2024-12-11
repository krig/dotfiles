return {
  {
    "pmizio/typescript-tools.nvim",
    ft = { "javascript", "typescript", "typescriptreact" },
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  {
    'ziglang/zig.vim',
    version = '*',
    ft = { "zig" },
    init = function()
      vim.g.zig_fmt_autosave = 0
    end,
  },
  {
    'bakpakin/janet.vim',
    ft = { "janet" },
  }
}
