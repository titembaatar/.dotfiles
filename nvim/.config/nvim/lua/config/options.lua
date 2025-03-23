-- General Neovim settings and options
local opt = vim.opt 

-- Line numbers
opt.number = true -- show line numbers
opt.relativenumber = true -- show relative line numbers

-- Tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.smartindent = true -- do smart autoindenting when starting a new line

-- Line wrapping
opt.wrap = false -- disable line wrapping

-- Search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if include mixed case in search, assumes case-sensitive
opt.hlsearch = true -- highlight all matches on previous search pattern
opt.incsearch = true -- show search matches as you type

-- Cursor line
opt.cursorline = false -- highlight the current cursor line

-- Appearance
opt.termguicolors = true -- true color support
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift
opt.scrolloff = 8 -- minimal number of screen lines to keep above and below the cursor
opt.sidescrolloff = 8 -- minimal number of screen columns to keep to the left and right of the cursor

-- Backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- Clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- Split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- Decrease update time
opt.updatetime = 100 -- faster completion
opt.timeoutlen = 300 -- time to wait for a mapped sequence to complete (in milliseconds)

-- Persistent undo history
opt.undofile = true -- enable persistent undo

-- Enable mouse mode
opt.mouse = "a" -- enable mouse for all modes

-- Decrease redrawing operations
opt.lazyredraw = true -- don't redraw screen while executing macros

-- Hidden buffers
opt.hidden = true -- enable background buffers

-- File encoding
opt.fileencoding = "utf-8" -- the encoding written to a file

-- Complete options
opt.completeopt = "menuone,noselect" -- better completion experience

-- Wildmode
opt.wildmode = "longest:full,full" -- command-line completion mode

-- Don't show mode since we will use a status line
opt.showmode = false

-- Don't show cmd unless explicitly needed
opt.cmdheight = 1

-- Improve UI
opt.pumheight = 10 -- pop up menu height
opt.showtabline = 2 -- always show tabs
opt.winblend = 0 -- transparency for floating windows
opt.pumblend = 0 -- transparency for popup menu

-- Faster scrolling
opt.ttyfast = true

-- Better line joins
opt.formatoptions:append { "j" } -- remove comment leader when joining lines

-- For nvim-tree or similar file explorers (empty or hidden by default)
opt.fillchars:append { eob = " " }
