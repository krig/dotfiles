return {
  {
    "rcarriga/nvim-notify",
    opts = function(_, opts)
      opts.render = "wrapped-compact"
      opts.stages = "static"
    end,
  },
}
