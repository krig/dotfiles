return {
  {
    "rcarriga/nvim-notify",
    level = 3,
    opts = function(_, opts)
      opts.render = "wrapped-compact"
      opts.stages = "static"
    end,
  },
}
