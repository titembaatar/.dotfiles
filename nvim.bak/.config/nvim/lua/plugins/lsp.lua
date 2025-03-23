return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			local capabilities = require('blink.cmp').get_lsp_capabilities()
			local lspconfig = require('lspconfig')
			lspconfig['bashls'].setup { capabilities = capabilities }
			lspconfig['docker_compose_language_service'].setup { capabilities = capabilities }
			lspconfig['dockerls'].setup { capabilities = capabilities }
			lspconfig['gopls'].setup { capabilities = capabilities }
			lspconfig['lua_ls'].setup { capabilities = capabilities }
			lspconfig['marksman'].setup { capabilities = capabilities }
			lspconfig['yamlls'].setup { capabilities = capabilities }
			lspconfig['pylsp'].setup { capabilities = capabilities }

			vim.api.nvim_create_autocmd('LspAttach', {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then return end

					if client.supports_method('textDocument/formatting') then
						-- Format current buffer on save
						vim.api.nvim_create_autocmd('BufWritePre', {
							buffer = args.buf,
							callback = function()
								vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
							end,
						})
					end
				end,
			})
		end,
	}
}
