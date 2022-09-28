-- Plugin Management
--local lspconfig = require "plugins.confs.lspconfs"
--local cmp = require "plugins.confs.cmp"

require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
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
  }
  use {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup(
      )
    end,
  }
  use { 'lukas-reineke/indent-blankline.nvim',
    requires = 'nvim-treesitter/nvim-treesitter',
    config = function()
      require("indent_blankline").setup {
        space_char_blankline = " ",
        show_current_context = true,
      }
    end
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use {
    'romgrk/barbar.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

end)
-- Theme Setup
-- vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
-- require("catppuccin").setup()
-- vim.cmd [[colorscheme catppuccin]]
vim.cmd("colorscheme nightfox")
require('gitsigns').setup()
--use(lspconfig)
require'lspconfig'.pyright.setup{}
