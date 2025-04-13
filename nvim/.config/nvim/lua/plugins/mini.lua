return {
  {
    "echasnovski/mini.nvim",
    version = false,
    event = "VeryLazy",
    config = function()
      -- Text editing --
      -- mini.ai
      require("mini.ai").setup({})

      -- mini.comment
      require("mini.comment").setup({
        options = {
          ignore_blank_line = true,
        },
      })

      -- mini.pairs
      require("mini.pairs").setup({})

      -- mini.surround
      require("mini.surround").setup({
        mappings = {
          add = "gsa",
          delete = "gsd",
          find = "gsf",
          find_left = "gsF",
          highlight = "gsh",
          replace = "gsr",
          update_n_lines = "gsn",
        },
      })

      -- General workflow --
      -- mini.bracketed
      require("mini.bracketed").setup({})

      -- mini.bufremove
      require("mini.bufremove").setup({})

      -- mini.files
      require("mini.files").setup({
        options = {
          show_hidden = true,
        },
      })

      -- Appearance --
      -- mini.cursorword
      require("mini.cursorword").setup({})

      -- mini.hipatterns
      require("mini.hipatterns").setup({
        highlighters = {
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
          deprecated = { pattern = "%f[%w]()DEPRECATED()%f[%W]", group = "MiniHipatternsDeprecated" },
        },
      })

      -- mini.icons
      require("mini.icons").setup({})

      -- mini.indentscope
      require("mini.indentscope").setup({
        draw = {
          animation = function()
            return 0
          end,
        },
        mappings = {
          object_scope = "",
          object_scope_with_border = "",
          goto_top = "",
          goto_bottom = "",
        },
        symbol = "│",
      })

      -- mini.statusline
      require("mini.statusline").setup({
        use_icons = true,
      })

      -- mini.tabline
      require("mini.tabline").setup({})

      -- mini.trailspace
      require("mini.trailspace").setup({})
      -- -- Auto-trim whitespace on save
      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --   pattern = "*",
      --   callback = function()
      --     require("mini.trailspace").trim()
      --   end,
      -- })
    end,
  },
}
