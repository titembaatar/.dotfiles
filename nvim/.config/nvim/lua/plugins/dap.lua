return {
  -- Core DAP plugin
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      -- Basic DAP keymaps
      vim.keymap.set("n", "<F5>", function() dap.continue() end, { desc = "Continue Debugging" })
      vim.keymap.set("n", "<F10>", function() dap.step_over() end, { desc = "Step Over" })
      vim.keymap.set("n", "<F11>", function() dap.step_into() end, { desc = "Step Into" })
      vim.keymap.set("n", "<F12>", function() dap.step_out() end, { desc = "Step Out" })
      vim.keymap.set("n", "<Leader>b", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
    end
  },

  -- Go Debug Adapter
  {
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-go").setup()
    end
  }
}
