-- leader
vim.g.mapleader = " "

-- lazy.nvim
require("config.lazy")

-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.wrap = false

-- Appearance
vim.o.guifont = "Iosevka:h12,Noto Color Emoji"
vim.cmd [[colorscheme sarnai]]

-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Terminal
vim.api.nvim_create_autocmd('TermOpen', {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
})

vim.keymap.set("n", "<leader>tt", function()
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 15)
end
)

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
