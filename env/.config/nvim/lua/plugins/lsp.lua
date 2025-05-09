return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSP
        "bashls",
        "cssls",
        "dockerls",
        "gopls",
        "html",
        "jsonls",
        "lua_ls",
        "marksman",
        "pyright",
        "ruby_lsp",
        "yamlls",

        -- Linters
        "shellcheck",
        "selene", -- Lua

        -- Formatters
        "stylua",
        "isort",
        "black",
      },
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      automatic_installation = true,
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
      "folke/lazydev.nvim",
    },
    opts = {
      capabilities = {},
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          prefix = "●",
        },
        severity_sort = true,
      },
      -- Default LSP server configuration
      servers = {
        bashls = {
          filetypes = { "sh", "bash" },
          settings = {
            bashIde = {
              shellcheckPath = "shellcheck",
            },
          },
        },
        cssls = {},
        dockerls = {},
        gopls = {},
        html = {},
        jsonls = {},
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
              diagnostics = {
                globals = { "vim" },
              },
              telemetry = {
                enable = false,
              },
            },
          },
        },
        marksman = {},
        pyright = {},
        ruby_lsp = {},
        yamlls = {},
      },
    },
    config = function(_, opts)
      require("lazydev").setup()

      local lspconfig = require("lspconfig")
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
        },
      })

      -- Configure diagnostics
      vim.diagnostic.config(opts.diagnostics)

      -- Setup auto-format on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
          vim.lsp.buf.format({ timeout_ms = 2000 })
        end,
      })

      -- Setup servers
      for server, config in pairs(opts.servers) do
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    dependencies = { "williamboman/mason.nvim" },
    opts = function(_, opts)
      local null_ls = require("null-ls")

      vim.list_extend(opts.sources or {}, {
        -- Lua formatting
        null_ls.builtins.formatting.stylua,

        -- Python formatting
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,

        -- Go formatting
        null_ls.builtins.formatting.gofmt,

        -- JSON/YAML formatting
        null_ls.builtins.formatting.prettier.with({
          filetypes = { "json", "yaml", "html", "css", "javascript" },
        }),
      })
    end,
  },

  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on Lua files
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
      fuzzy = {
        implementation = 'prefer_rust_with_warning',
        prebuilt_binaries = {
          download = true,
          force_version = "v1.0.0",
        },
      },
    },
  },
}
