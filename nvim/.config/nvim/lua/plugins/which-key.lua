return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      spec = {
        { "<leader>b", group = "Buffer" },
        { "<leader>c", group = "Code" },
        { "<leader>d", group = "Debug" },
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>q", group = "Session" },
        { "<leader>t", group = "Tab/Toggle" },
        { "<leader>w", group = "Window" },
        { "<leader>x", group = "Diagnostics" },
      },
      icons = {
        breadcrumb = ";",
        separator = "|",
      },
      win = {
        width = 32,
        height = { min = 4, max = 50 },
        row = 0,
        col = math.huge,
      },
      layout = {
        width = { max = 20 },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}
