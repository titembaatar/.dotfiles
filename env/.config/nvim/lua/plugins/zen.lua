return {
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        backdrop = 0.9,
        options = {
          signcolumn = "no",
          number = false,
          relativenumber = false,
          cursorline = false,
          cursorcolumn = false,
          foldcolumn = "0",
          list = false,
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
          laststatus = 0,
        },
        twilight = { enabled = true },
        gitsigns = { enabled = false },
        tmux = { enabled = true },
        todo = { enabled = false },
        kitty = {
          enabled = true,
          font = "+2",
        },
      },
      -- callback where you can add custom code when the Zen window opens
      on_open = function(win)
        Util.ToggleColorColumn()
      end,
    },
  }
}
