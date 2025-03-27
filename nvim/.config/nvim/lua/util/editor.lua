local M = {}

local colorcolumn_values = {}

function M.ToggleColorColumn()
  local bufnr = vim.api.nvim_get_current_buf()
  local current_cc = vim.opt_local.colorcolumn:get()[1]

  if current_cc then
    colorcolumn_values[bufnr] = current_cc
    vim.opt_local.colorcolumn = ""
  else
    local restored = false

    if colorcolumn_values[bufnr] then
      vim.opt_local.colorcolumn = colorcolumn_values[bufnr]
      restored = true
    end

    if not restored then
      vim.cmd("setlocal colorcolumn=100")
    end
  end
end

return M
