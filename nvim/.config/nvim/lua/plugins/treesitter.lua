return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/playground" },
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "go", "bash", "markdown", "markdown_inline", "yaml", "toml" },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        playground = { enable = true },
      })
    end
  }
}
