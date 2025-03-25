-- Settings for TOML files
local set = vim.opt_local

set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true   -- Use spaces for TOML
set.textwidth = 80     -- Common for config files
set.colorcolumn = "80" -- Show visual marker

-- Detect common TOML files without extension
vim.cmd([[
  augroup toml_filetype
    autocmd!
    autocmd BufNewFile,BufRead Cargo.toml,*.toml.tmpl setfiletype toml
  augroup END
]])
