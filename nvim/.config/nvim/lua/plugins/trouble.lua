return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
      position = "bottom",
      height = 10,
      icons = true,
      group = true,
      padding = true,
      indent_lines = true,
      win_config = { border = "single" },
    },
  }
}
