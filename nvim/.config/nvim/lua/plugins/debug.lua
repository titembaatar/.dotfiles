return {
  {
    "mfussenegger/nvim-dap",
    enabled = false,
    dependencies = {
      { "rcarriga/nvim-dap-ui",         dependencies = { "nvim-neotest/nvim-nio", }, },
      { "jay-babu/mason-nvim-dap.nvim", dependencies = { "williamboman/mason.nvim", }, },
      { "mfussenegger/nvim-dap-python", ft = "python" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "+" },
        layouts = {
          {
            elements = {
              "scopes",
              "watches",
              "breakpoints",
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              "repl",
            },
            size = 10,
            position = "bottom",
          },
        },
      })

      -- Automatically open/close the DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Use mason-nvim-dap for adapter setup (leveraging existing Mason)
      require("mason-nvim-dap").setup({
        -- Use Mason to install these adapters
        ensure_installed = { "python", "delve" },
        -- Simple automatic setup
        automatic_installation = true,
        -- Use default handlers for all adapters
        handlers = {},
      })

      -- Set up Python adapter
      require("dap-python").setup("python")
    end,
  },
}
