-- Settings for CSS files
local set = vim.opt_local

set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true    -- Use spaces instead of tabs
set.textwidth = 100     -- Common for web development
set.colorcolumn = "100" -- Show visual marker

-- Set smart indenting for CSS
set.smartindent = true

-- Proper CSS-specific settings
set.iskeyword:append("-") -- Treat hyphenated words as one word for CSS properties
