-- Settings for Markdown files
local set = vim.opt_local

set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true   -- Use spaces for Markdown
set.textwidth = 80     -- Common for markdown readability
set.colorcolumn = "80" -- Show visual marker
set.conceallevel = 0   -- Don't hide markdown syntax

-- Enable spell checking for markdown files
set.spell = true
set.spelllang = "en_us"

-- Wrap text in markdown files
set.wrap = true
set.linebreak = true -- Break at word boundaries
