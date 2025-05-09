-- Settings for JSON files
local set = vim.opt_local

set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true -- JSON uses spaces by convention
set.textwidth = 0    -- Disable auto wrapping for JSON

-- Enable folding by syntax for JSON
set.foldmethod = "syntax"
set.foldenable = false -- But don't start folded

-- Detect common JSON files even without extension
vim.cmd([[
  augroup json_filetype
    autocmd!
    autocmd BufNewFile,BufRead .prettierrc,.eslintrc setfiletype json
    autocmd BufNewFile,BufRead tsconfig.json,package.json,*.jsonc setlocal commentstring=//\ %s
  augroup END
]])
