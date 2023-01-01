-- Tab 2 Spaces
vim.bo.expandtab = true -- convert tabs to spaces
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2


-- General Settings
vim.opt.ignorecase = true -- ignore case in search patterns
-- vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.termguicolors = true

-- Relative Numbers
vim.opt.number = true
vim.opt.relativenumber = true
-- Leader Space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- nvim files
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.writebackup = false
