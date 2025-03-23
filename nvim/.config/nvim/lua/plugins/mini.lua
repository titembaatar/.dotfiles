return {
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      -- mini.files
      require("mini.files").setup({
        options = {
          show_hidden = true,
        },
      })

      vim.api.nvim_set_keymap(
        "n",
        "<leader>e",
        ":lua require('mini.files').open()<CR>",
        { noremap = true, silent = true, desc = "Open file explorer" }
      )

      -- mini.comment
      require("mini.comment").setup({
        options = {
          ignore_blank_line = true,
        },
      })

      -- mini.pairs
      require("mini.pairs").setup({
      })

      -- mini.surround
      require("mini.surround").setup({
      })

      -- mini.ai
      require("mini.ai").setup({
      })

      -- mini.indentscope
      require("mini.indentscope").setup({
        draw = {
          animation = function() return 0 end,
        },
      })

      -- mini.statusline
      require("mini.statusline").setup({
        use_icons = true,
      })

      -- mini.bufremove
      require("mini.bufremove").setup({})
      vim.api.nvim_set_keymap("n", "<leader>bd", ":lua MiniBufremove.delete()<CR>",
        { noremap = true, silent = true, desc = "Delete buffer" })
      vim.api.nvim_set_keymap("n", "<leader>bD", ":lua MiniBufremove.delete(true)<CR>",
        { noremap = true, silent = true, desc = "Force delete buffer" })

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
      require("mini.jump2d").setup({
      })

      -- mini.trailspace
      require("mini.trailspace").setup({})
      -- Auto-trim whitespace on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function()
          require("mini.trailspace").trim()
        end,
      })

      -- mini.tabline
      require("mini.tabline").setup({})
    end,
  },
}
