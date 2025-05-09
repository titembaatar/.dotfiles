return {
  {
    "echasnovski/mini.nvim",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.ai").setup({})
      require("mini.bracketed").setup({})
      require("mini.bufremove").setup({})
      require("mini.cursorword").setup({})
      require("mini.icons").setup({})
      require("mini.pairs").setup({})
      require('mini.sessions').setup({})
      require("mini.tabline").setup({})
      require("mini.trailspace").setup({})

      require("mini.comment").setup({
        options = {
          ignore_blank_line = true,
        },
      })

      require("mini.files").setup({
        options = {
          show_hidden = true,
        },
      })

      require("mini.hipatterns").setup({
        highlighters = {
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
          deprecated = { pattern = "%f[%w]()DEPRECATED()%f[%W]", group = "MiniHipatternsDeprecated" },
        },
      })

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

      require("mini.statusline").setup({
        use_icons = true,
      })

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
    end,
  },
}
