return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
      auto_close = true,
      win = {
        position = "right",
        size = 0.3,
      },
      preview = {
        type = "split",
        relative = "win",
        position = "bottom",
        size = 0.5,
      },
    },
  },
}
