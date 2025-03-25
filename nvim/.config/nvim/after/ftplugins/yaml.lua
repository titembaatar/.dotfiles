-- Settings for YAML files
local set = vim.opt_local

set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true   -- YAML requires spaces
set.textwidth = 80     -- Common for configuration files
set.colorcolumn = "80" -- Show visual marker

-- Detect common YAML files even without extension
vim.cmd([[
  augroup yaml_filetype
    autocmd!
    autocmd BufNewFile,BufRead *.yml.j2,*.yaml.j2 setfiletype yaml
    autocmd BufNewFile,BufRead .yamllint,.yamlfmt setfiletype yaml
  augroup END
]])
