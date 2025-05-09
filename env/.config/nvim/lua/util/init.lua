local M = {}

---@type table<function>
local to_export = {
  require("util.bufremove"),
  require("util.editor"),

  ---Add more modules to export
  -- require("util.newmodule"),
}

---Export all functions starting with capital letter
---@param modules table
---@param util_module table
local function export(modules, util_module)
  for _, module in ipairs(modules) do
    for key, value in pairs(module) do
      if type(key) == "string" and key:match("^%u") and type(value) == "function" then
        util_module[key] = value
      end
    end
  end
end

export(to_export, M)

return M
