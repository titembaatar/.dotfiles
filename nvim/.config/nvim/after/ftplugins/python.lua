-- Settings for Python files following PEP 8
local set = vim.opt_local

set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = true   -- Use spaces instead of tabs (PEP 8)
set.textwidth = 88     -- Black formatter default (was 79 in PEP 8)
set.colorcolumn = "88" -- Show visual marker
set.smartindent = true -- Smart indenting for Python

-- Add Python path to include path for better gf functionality
set.path:append("**")
