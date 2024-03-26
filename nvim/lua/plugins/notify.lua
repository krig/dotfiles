return {
  {
    "rcarriga/nvim-notify",
    enabled = false,
    opts = function(_, opts)
      opts.render = "wrapped-compact"
      opts.stages = "static"
    end,
  },
}
