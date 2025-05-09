local M = {}

function M.getBuf()
  local current_buf = vim.api.nvim_get_current_buf()

  local list_buffers = vim.tbl_filter(
    function(buf_id)
      return vim.api.nvim_buf_is_valid(buf_id) and vim.bo[buf_id].buflisted
    end,
    vim.api.nvim_list_bufs()
  )

  return current_buf, list_buffers
end

function M.DeleteBuffersOnRight()
  local buf_current, buf_list = M.getBuf()

  local found = false
  for _, buf_id in ipairs(buf_list) do
    if found then
      require('mini.bufremove').delete(buf_id, false)
    elseif buf_id == buf_current then
      found = true
    end
  end
end

function M.DeleteBuffersOnLeft()
  local buf_current, buf_list = M.getBuf()

  for _, buf_id in ipairs(buf_list) do
    if buf_id == buf_current then
      break
    else
      require('mini.bufremove').delete(buf_id, false)
    end
  end
end

return M
