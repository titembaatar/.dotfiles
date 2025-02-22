return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          -- formatters
          null_ls.builtins.formatting.gofmt,   -- standard go formatter
          null_ls.builtins.formatting.goimports, -- auto-imports in go
          null_ls.builtins.formatting.golines, -- auto-wraps long lines

          -- linters
          null_ls.builtins.diagnostics.golangci_lint, -- best linter for go

          -- code actions
          null_ls.builtins.code_actions.gomodifytags, -- modify struct tags easily
          null_ls.builtins.code_actions.impl,       -- generate interface implementations
        },
      })
    end
  }
}
