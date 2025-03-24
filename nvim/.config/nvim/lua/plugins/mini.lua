return {
  {
    "echasnovski/mini.nvim",
    version = false,
    event = "VeryLazy",
    config = function()
      -- mini.files
      require("mini.files").setup({
        options = {
          show_hidden = true,
        },
      })

      -- mini.comment
      require("mini.comment").setup({
        options = {
          ignore_blank_line = true,
        },
      })

      -- mini.icons
      require("mini.icons").setup({})

      -- mini.pairs
      require("mini.pairs").setup({})

      -- mini.surround
      require("mini.surround").setup({})

      -- mini.ai
      require("mini.ai").setup({})

      -- mini.indentscope
      require("mini.indentscope").setup({
        draw = {
          animation = function()
            return 0
          end,
        },
      })

      -- mini.statusline
      require("mini.statusline").setup({
        use_icons = true,
      })

      -- mini.git
      require("mini.git").setup({})

      -- mini.diff
      require("mini.diff").setup({})

      -- mini.bufremove
      require("mini.bufremove").setup({})

      -- mini.cursorword
      require("mini.cursorword").setup({})

      -- mini.hipatterns
      require("mini.hipatterns").setup({
        highlighters = {
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsFixme" },
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
          deprecated = { pattern = "%f[%w]()DEPRECATED()%f[%W]", group = "MiniHipatternsDeprecated" },
        },
      })

      -- mini.jump2d
      require("mini.jump2d").setup({})

      -- mini.trailspace
      require("mini.trailspace").setup({})
      -- Auto-trim whitespace on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function()
          require("mini.trailspace").trim()
        end,
      })

      -- mini.bracketed
      require("mini.bracketed").setup({})

      -- mini.tabline
      require("mini.tabline").setup({})
    end,
  },
}
