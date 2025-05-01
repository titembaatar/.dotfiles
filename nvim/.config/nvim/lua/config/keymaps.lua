-- Key mappings

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local k = vim.keymap

---------------------
-- General Keymaps --
---------------------

-- Clear search highlights
k.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Delete single character without copying into register
k.set("n", "x", '"_x', { desc = "Delete character without copying" })

-- Window management (using 'w' group for window)
k.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
k.set("n", "<leader>ws", "<C-w>s", { desc = "Split window horizontally" })
k.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" })
k.set("n", "<leader>wx", ":close<CR>", { desc = "Close current split" })

-- Windows navigation
k.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
k.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
k.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
k.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Indentation management
k.set("v", "<", "<gv", { desc = "Decrease indent and reselect" })
k.set("v", ">", ">gv", { desc = "Increase indent and reselect" })

-- Move lines up and down
k.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines down" })
k.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines up" })

-- Keep cursor in place when joining lines
k.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor in place" })

-- Keep cursor centered when scrolling
k.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
k.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Keep cursor centered when searching
k.set("n", "n", "nzzzv", { desc = "Next search result and center" })
k.set("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- Paste without overwriting register
k.set("x", "<leader>p", [["_dP]], { desc = "Paste without overwriting register" })

-- Escape in terminal mode
k.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Buffer navigation
k.set("n", "H", ":bprevious<CR>", { noremap = true, silent = true, desc = "Previous buffer" })
k.set("n", "L", ":bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })

-- Inspect highlights
k.set("n", "<leader>ci", "<Cmd>Inspect<CR>", { desc = "Inspect highlights" })

--------------------------
-- Plugin-Based Keymaps --
--------------------------

-- Which-key <leader>? --
k.set("n", "<leader>?", function() require("which-key").show({ global = false }) end, { desc = "Help" })

-- Zen Mode <leader>z --
k.set("n", "<leader>z", "<Cmd>ZenMode<CR>", { desc = "Zen Mode" })

-- Mason <leader>m --
k.set("n", "<leader>m", "<Cmd>Mason<CR>", { desc = "Mason" })

-- Quick picker access
k.set("n", "<leader><space>", "<Cmd>lua Snacks.picker.smart()<CR>", { desc = "Smart Find Files" })

-- Snacks Dashboard
k.set("n", "<leader><Esc>", "<Cmd>lua Snacks.dashboard()<CR>", { desc = "Dashboard" })

----------------------
-- Grouped Keymaps  --
----------------------

-- Buffers <leader>b --
k.set("n", "<leader>bd", "<Cmd>lua MiniBufremove.delete()<CR>", { desc = "Delete buffer" })
k.set("n", "<leader>bD", "<Cmd>lua MiniBufremove.delete(true)<CR>", { desc = "Force delete buffer" })
k.set("n", "<leader>bl", "<Cmd>lua Util.DeleteBuffersOnLeft()<CR>", { desc = "Delete buffers on left" })
k.set("n", "<leader>br", "<Cmd>lua Util.DeleteBuffersOnRight()<CR>", { desc = "Delete buffers on right" })

-- Code <leader>c --
k.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
k.set("n", "<leader>cd", vim.diagnostic.open_float, { noremap = true, silent = true, desc = "Show Diagnostic" })
k.set("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format Document" })
k.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })

-- Debug <leader>d --
k.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
k.set("n", "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
  { desc = "Conditional Breakpoint" })
k.set("n", "<leader>dc", function() require("dap").continue() end, { desc = "Continue" })
k.set("n", "<leader>di", function() require("dap").step_into() end, { desc = "Step Into" })
k.set("n", "<leader>dn", function() require("dap").step_over() end, { desc = "Step Over" })
k.set("n", "<leader>do", function() require("dap").step_out() end, { desc = "Step Out" })
k.set("n", "<leader>dq", function() require("dap").terminate() end, { desc = "Terminate" })
k.set("n", "<leader>du", function() require("dapui").toggle() end, { desc = "Toggle DAP UI" })

-- Find <leader>f --
k.set("n", "<leader>fb", "<Cmd>lua Snacks.picker.buffers()<CR>", { desc = "Buffers" })
k.set("n", "<leader>fd", "<Cmd>lua Snacks.picker.diagnostics()<CR>", { desc = "Diagnostics" })
k.set("n", "<leader>fD", "<Cmd>lua Snacks.picker.diagnostics_buffer()<CR>", { desc = "Buffer Diagnostics" })
k.set("n", "<leader>fe", ":lua require('mini.files').open()<CR>",
  { noremap = true, silent = true, desc = "Open file explorer" })
k.set("n", "<leader>ff", "<Cmd>lua Snacks.picker.files()<CR>", { desc = "Find Files" })
k.set("n", "<leader>fg", "<Cmd>lua Snacks.picker.grep()<CR>", { desc = "Grep" })
k.set("n", "<leader>fq", "<Cmd>lua Snacks.picker.qflist()<CR>", { desc = "Quickfix List" })
k.set("n", "<leader>fw", "<Cmd>lua Snacks.picker.grep_word()<CR>", { desc = "Visual selection or word" })

-- Git <leader>g --
k.set("n", "<leader>gb", "<Cmd>lua Snacks.picker.git_branches()<CR>", { desc = "Git Branches" })
k.set("n", "<leader>gB", "<Cmd>Gitsigns blame_line<CR>", { desc = "Blame Line" })
k.set("n", "<leader>gd", "<Cmd>lua Snacks.picker.git_diff()<CR>", { desc = "Git Diff (Hunks)" })
k.set("n", "<leader>gD", "<Cmd>Gitsigns toggle_word_diff<CR>", { desc = "Word Diff" })
k.set("n", "<leader>gf", "<Cmd>LazyGitCurrentFile<CR>", { desc = "LazyGit Current File" })
k.set("n", "<leader>gg", "<Cmd>LazyGit<CR>", { desc = "LazyGit" })
k.set("n", "<leader>gh", "<Cmd>Gitsigns preview_hunk_inline<CR>", { desc = "Preview Hunk" })
k.set("n", "<leader>gs", "<Cmd>lua Snacks.picker.git_status()<CR>", { desc = "Git Status" })
k.set("n", "]h", "<Cmd>Gitsigns nav_hunk next<CR>", { desc = "Next Hunk" })
k.set("n", "[h", "<Cmd>Gitsigns nav_hunk prev<CR>", { desc = "Prev Hunk" })

-- Sessions <leader>q --
k.set("n", "<leader>qs", function() require("persistence").load() end, { desc = "Load Session" })
k.set("n", "<leader>qS", function() require("persistence").select() end, { desc = "Select Session" })
k.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end, { desc = "Last Session" })
k.set("n", "<leader>qd", function() require("persistence").stop() end, { desc = "Don't Save Session" })

-- Search <leader>s --
k.set("n", "<leader>sc", "<Cmd>lua Snacks.picker.files({ cwd = vim.fn.stdpath(\"config\")})<CR>",
  { desc = "Config Files" })
k.set("n", "<leader>sh", "<Cmd>lua Snacks.picker.help()<CR>", { desc = "Help Pages" })
k.set("n", "<leader>sH", "<Cmd>lua Snacks.picker.highlights()<CR>", { desc = "Highlights" })
k.set("n", "<leader>sm", "<Cmd>lua Snacks.picker.man()<CR>", { desc = "Man Pages" })
k.set("n", "<leader>sp", "<Cmd>lua Snacks.picker.projects()<CR>", { desc = "Projects" })

-- Toggle <leader>t --
k.set("n", "<leader>tc", "<Cmd>lua Util.ToggleColorColumn()<CR>", { desc = "Toggle Color Column" })

-- Trouble <leader>x --
k.set("n", "<leader>xl", "<Cmd>Trouble lsp toggle focus=false win.position=right<CR>",
  { desc = "LSP Definitions / references / ..." })
k.set("n", "<leader>xL", "<Cmd>Trouble loclist toggle<CR>", { desc = "Location List" })
k.set("n", "<leader>xQ", "<Cmd>Trouble qflist toggle<CR>", { desc = "Quickfix List" })
k.set("n", "<leader>xs", "<Cmd>Trouble symbols toggle focus=false<CR>", { desc = "Symbols" })
k.set("n", "<leader>xx", "<Cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics" })
k.set("n", "<leader>xX", "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Buffer Diagnostics" })

--------------------------
-- LSP Related Keymaps  --
--------------------------

k.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
k.set("n", "gd", "<Cmd>lua Snacks.picker.lsp_definitions()<CR>", { desc = "Goto Definition" })
k.set("n", "gD", "<Cmd>lua Snacks.picker.lsp_declarations()<CR>", { desc = "Goto Declaration" })
k.set("n", "gI", "<Cmd>lua Snacks.picker.lsp_implementations()<CR>", { desc = "Goto Implementation" })
k.set("n", "gr", "<Cmd>lua Snacks.picker.lsp_references()<CR>", { nowait = true, desc = "References" })
k.set("n", "gy", "<Cmd>lua Snacks.picker.lsp_type_definitions()<CR>", { desc = "Goto T[y]pe Definition" })

k.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Previous Diagnostic" })
k.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next Diagnostic" })


-----------------------------
-- FzfLua Related Keymaps  --
-----------------------------

-- k.set("n", "<leader><leader>", "<Cmd>FzfLua files<CR>", { desc = "Find files" })

-- FZF-Lua
-- k.set("n", "<leader>fb", "<Cmd>FzfLua buffers<CR>", { desc = "Find buffers" })
-- k.set("n", "<leader>fd", "<Cmd>FzfLua files cwd=~/.dotfiles/<CR>", { desc = "Find in .dotfiles" })
-- k.set("n", "<leader>ff", "<Cmd>FzfLua files<CR>", { desc = "Find files" })
-- k.set("n", "<leader>fg", "<Cmd>FzfLua live_grep<CR>", { desc = "Grep in files" })
-- k.set("n", "<leader>fh", "<Cmd>FzfLua help_tags<CR>", { desc = "Help tags" })
-- k.set("n", "<leader>fm", "<Cmd>FzfLua files cwd=/usr/share/man/<CR>", { desc = "Manuals" })
-- k.set("n", "<leader>fn", "<Cmd>FzfLua files cwd=~/.config/nvim<CR>", { desc = "Find in Neovim config" })
-- k.set("n", "<leader>fp", "<Cmd>FzfLua live_grep search_paths={\"~/code\"}<CR>", { desc = "Find projects" })
-- k.set("n", "<leader>fw", "<Cmd>FzfLua grep_cword<CR>", { desc = "Find word under cursor" })

-- Git with FZF-Lua
-- k.set("n", "<leader>gb", "<Cmd>FzfLua git_branches<CR>", { desc = "Git Branches" })
-- k.set("n", "<leader>gc", "<Cmd>FzfLua git_commits<CR>", { desc = "Git Commits" })
-- k.set("n", "<leader>gs", "<Cmd>FzfLua git_status<CR>", { desc = "Git Status" })

-- LSP thingies
-- k.set("n", "gd", "<Cmd>FzfLua lsp_definitions<CR>", { desc = "Go to Definition" })
-- k.set("n", "gr", "<Cmd>FzfLua lsp_references<CR>", { desc = "Go to References" })
-- k.set("n", "gI", "<Cmd>FzfLua lsp_implementations<CR>", { desc = "Go to Implementation" })
-- k.set("n", "gt", "<Cmd>FzfLua lsp_typedefs<CR>", { desc = "Go to Type Definition" })
