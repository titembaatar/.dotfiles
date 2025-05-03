-- General Neovim settings and options
local opt = vim.opt

-- test
opt.guicursor = "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor/lCursor,r-cr:hor20,o:hor50"

-- Line numbers
opt.number = true         -- show line numbers
opt.relativenumber = true -- show relative line numbers

-- Set default tab behavior
opt.tabstop = 2        -- Number of spaces a tab counts for
opt.shiftwidth = 2     -- Number of spaces to use for auto-indent
opt.softtabstop = 2    -- Number of spaces a tab counts for during editing
opt.expandtab = true   -- Use spaces instead of tabs by default
opt.autoindent = true  -- Copy indent from current line when starting new one
opt.smartindent = true -- Auto-indent new lines

-- Line width and visualization
opt.textwidth = 100     -- Default text width
opt.colorcolumn = "100" -- Visual marker for line length
opt.wrap = false        -- Don't wrap lines by default

-- Search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true  -- if include mixed case in search, assumes case-sensitive
opt.hlsearch = true   -- highlight all matches on previous search pattern
opt.incsearch = true  -- show search matches as you type

-- Cursor line
opt.cursorline = false -- highlight the current cursor line

-- Appearance
vim.o.termguicolors = true -- true color support
opt.background = "dark"    -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes"     -- show sign column so that text doesn't shift
opt.scrolloff = 8          -- minimal number of screen lines to keep above and below the cursor
opt.sidescrolloff = 8      -- minimal number of screen columns to keep to the left and right of the cursor

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
opt.pumheight = 10  -- pop up menu height
opt.showtabline = 2 -- always show tabs
opt.winblend = 0    -- transparency for floating windows
opt.pumblend = 0    -- transparency for popup menu

-- Faster scrolling
opt.ttyfast = true

-- Better line joins
opt.formatoptions:append { "j" } -- remove comment leader when joining lines

-- For nvim-tree or similar file explorers (empty or hidden by default)
opt.fillchars:append { eob = " " }

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch", -- You can use different highlight groups: Visual, Search, etc.
      timeout = 200,         -- Time in milliseconds the highlight remains
      on_macro = true,       -- Also highlight when running a macro
      on_visual = true       -- Also highlight when yanking a visual selection
    })
  end,
  group = highlight_group,
})

-- Disable mini.trailspace in snacks.dashboard
local disableTrailspace = function(args) vim.b[args.buf].minitrailspace_disable = true end
vim.api.nvim_create_autocmd('User', { pattern = 'SnacksDashboardOpened', callback = disableTrailspace })

-- Disable mini.sessions, conflict with snacks.picker projects
vim.g.minisessions_disable = true
