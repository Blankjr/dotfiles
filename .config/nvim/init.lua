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
local keymap = vim.api.nvim_set_keymap
-- Save
keymap('n', '<c-s>', ':w<CR>', {})
keymap('i', '<c-s>', '<ESC>:w<CR>a', {})
local opts = { noremap = true }
-- Fast Escape insert mode
keymap('i', 'jj', '<ESC>', {})
-- Move between splits with CTRL + hjkl
keymap('n', '<c-j>', '<c-w>j', opts)
keymap('n', '<c-h>', '<c-w>h', opts)
keymap('n', '<c-k>', '<c-w>k', opts)
keymap('n', '<c-l>', '<c-w>l', opts)
-- Plugin Keymaps
keymap('n', '<leader>gg', ':LazyGit<CR>', {})
-- Telescope
keymap('n', '<leader>ff', ':Telescope find_files<CR>', {})
keymap('n', '<leader>fg', ':Telescope live_grep<CR>', {})
keymap('n', '<leader>fb', ':Telescope buffers<CR>', {})
keymap('n', '<leader>fh', ':Telescope help_tags<CR>', {})
-- Plugin Management
require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- use { "catppuccin/nvim", as = "catppuccin" }
  use "EdenEast/nightfox.nvim"
  use { "kdheepak/lazygit.nvim" }
  use {
    'lewis6991/gitsigns.nvim',
    -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
  }
  use 'andweeb/presence.nvim'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } },
    use {
      "max397574/better-escape.nvim",
      config = function()
        require("better_escape").setup(
        )
      end,
    }
  }
end)
-- Theme Setup
-- vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
-- require("catppuccin").setup()
-- vim.cmd [[colorscheme catppuccin]]
vim.cmd("colorscheme nightfox")
require('gitsigns').setup()
