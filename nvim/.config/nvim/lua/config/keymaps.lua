-- Key mappings

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local keymap = vim.keymap

---------------------
-- General Keymaps --
---------------------

-- Clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Delete single character without copying into register
keymap.set("n", "x", '"_x', { desc = "Delete character without copying" })

-- Window management (using 'w' group for window)
keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>wx", ":close<CR>", { desc = "Close current split" })

-- Windows navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Indentation management
keymap.set("v", "<", "<gv", { desc = "Decrease indent and reselect" })
keymap.set("v", ">", ">gv", { desc = "Increase indent and reselect" })

-- Move lines up and down
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines up" })

-- Keep cursor in place when joining lines
keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor in place" })

-- Keep cursor centered when scrolling
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Keep cursor centered when searching
keymap.set("n", "n", "nzzzv", { desc = "Next search result and center" })
keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- Paste without overwriting register
keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without overwriting register" })

-- Escape in terminal mode
keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Buffer navigation
keymap.set("n", "H", ":bprevious<CR>", { noremap = true, silent = true, desc = "Previous buffer" })
keymap.set("n", "L", ":bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })

--------------------------
-- Plugin-Based Keymaps --
--------------------------

-- Which-key <leader>? --
keymap.set("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Help" })

-- Zen Mode <leader>z --
keymap.set("n", "<leader>z", "<cmd>ZenMode<cr>", { desc = "Zen Mode" })

-- Mason <leader>m --
keymap.set("n", "<leader>m", "<cmd>Mason<cr>", { desc = "Mason" })

-- Quick FZF access
keymap.set("n", "<leader><leader>", "<cmd>FzfLua files<cr>", { desc = "Find files" })

----------------------
-- Grouped Keymaps  --
----------------------

-- Buffers <leader>b --
keymap.set("n", "<leader>bd", ":lua MiniBufferRemove.delete()<CR>",
  { noremap = true, silent = true, desc = "Delete buffer" })
keymap.set("n", "<leader>bD", ":lua MiniBufferRemove.delete(true)<CR>",
  { noremap = true, silent = true, desc = "Force delete buffer" })

-- Debug <leader>d --
keymap.set("n", "<leader>dc", function() require("dap").continue() end, { desc = "Continue" })
keymap.set("n", "<leader>dq", function() require("dap").terminate() end, { desc = "Terminate" })
keymap.set("n", "<leader>dn", function() require("dap").step_over() end, { desc = "Step Over" })
keymap.set("n", "<leader>di", function() require("dap").step_into() end, { desc = "Step Into" })
keymap.set("n", "<leader>do", function() require("dap").step_out() end, { desc = "Step Out" })
keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
keymap.set("n", "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
  { desc = "Conditional Breakpoint" })
keymap.set("n", "<leader>du", function() require("dapui").toggle() end, { desc = "Toggle DAP UI" })

-- Find <leader>f --
-- mini.files
keymap.set("n", "<leader>fe", ":lua require('mini.files').open()<CR>",
  { noremap = true, silent = true, desc = "Open file explorer" })
-- FZF-Lua
keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Find files" })
keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>", { desc = "Grep in files" })
keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "Find buffers" })
keymap.set("n", "<leader>fw", "<cmd>FzfLua grep_cword<cr>", { desc = "Find word under cursor" })
keymap.set("n", "<leader>fh", "<cmd>FzfLua help_tags<cr>", { desc = "Help tags" })
keymap.set("n", "<leader>fn", "<cmd>FzfLua files cwd=~/.config/nvim<cr>", { desc = "Find in Neovim config" })
keymap.set("n", "<leader>fp", "<cmd>Telescope projects<CR>", { desc = "Projects" })
keymap.set("n", "<leader>fd", "<cmd>FzfLua files cwd=~/.dotfiles/<cr>", { desc = "Find in .dotfiles" })

-- Git <leader>g --
-- LazyGit
keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "LazyGit" })
keymap.set("n", "<leader>gf", "<cmd>LazyGitCurrentFile<CR>", { desc = "LazyGit Current File" })
-- Git with FZF-Lua
keymap.set("n", "<leader>gc", "<cmd>FzfLua git_commits<cr>", { desc = "Git Commits" })
keymap.set("n", "<leader>gs", "<cmd>FzfLua git_status<cr>", { desc = "Git Status" })
keymap.set("n", "<leader>gb", "<cmd>FzfLua git_branches<cr>", { desc = "Git Branches" })
-- GitSigns
keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame_line", { desc = "Blame Line" })
keymap.set("n", "<leader>gd", "<cmd>Gitsigns toggle_word_diff", { desc = "Word Diff" })
keymap.set("n", "<leader>gh", "<cmd>Gitsigns preview_hunk_inline", { desc = "Preview Hunk" })
keymap.set("n", "]h", "<cmd>Gitsigns nav_hunks next", { desc = "Next Hunk" })
keymap.set("n", "[h", "<cmd>Gitsigns nav_hunks prev", { desc = "Prev Hunk" })

-- Sessions <leader>q --
keymap.set("n", "<leader>qs", function() require("persistence").load() end, { desc = "Load Session" })
keymap.set("n", "<leader>qS", function() require("persistence").select() end, { desc = "Select Session" })
keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end, { desc = "Last Session" })
keymap.set("n", "<leader>qd", function() require("persistence").stop() end, { desc = "Don't Save Session" })

-- Trouble <leader>x --
keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics" })
keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics" })
keymap.set("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols" })
keymap.set("n", "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
  { desc = "LSP Definitions / references / ..." })
keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List" })
keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List" })

--------------------------
-- LSP Related Keymaps  --
--------------------------

-- LSP navigation with FZF-Lua
keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<cr>", { desc = "Go to Definition" })
keymap.set("n", "gr", "<cmd>FzfLua lsp_references<cr>", { desc = "Go to References" })
keymap.set("n", "gI", "<cmd>FzfLua lsp_implementations<cr>", { desc = "Go to Implementation" })
keymap.set("n", "gt", "<cmd>FzfLua lsp_typedefs<cr>", { desc = "Go to Type Definition" })

-- LSP keymaps to be set on LSP attach
local lsp_keymaps = {
  ["on_attach"] = function(client, buffer)
    -- Navigation
    keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = buffer, desc = "Go to Declaration" })
    keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buffer, desc = "Hover Documentation" })

    -- Actions
    keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = buffer, desc = "Code Action" })
    keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = buffer, desc = "Rename" })
    keymap.set("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end,
      { buffer = buffer, desc = "Format Document" })

    -- Diagnostic navigation
    keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = buffer, desc = "Previous Diagnostic" })
    keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = buffer, desc = "Next Diagnostic" })
  end
}

return lsp_keymaps
