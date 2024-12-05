return {
  {
    "ChrisWellsWood/roc.vim",
    ft = { "roc" },
  },
  {
    'ziglang/zig.vim',
    version = '*',
    ft = { "zig" },
    init = function ()
      vim.g.zig_fmt_autosave = 0
    end,
  },
  {
    'bakpakin/janet.vim',
  },
  {
    'gleam-lang/gleam.vim',
  }
}
