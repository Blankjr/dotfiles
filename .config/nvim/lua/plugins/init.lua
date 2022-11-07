-- Plugin Management
--local lspconfig = require "plugins.confs.lspconfs"
local cmp = require("plugins.confs.cmp")

require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	use("neovim/nvim-lspconfig") -- Configurations for Nvim LSP
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})
	use(cmp)
	-- use { "catppuccin/nvim", as = "catppuccin" }
	use("EdenEast/nightfox.nvim")
	use({ "kdheepak/lazygit.nvim" })
	use({
		"lewis6991/gitsigns.nvim",
		-- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
	})
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		requires = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("indent_blankline").setup({
				space_char_blankline = " ",
				show_current_context = true,
			})
		end,
	})
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	use({
		"romgrk/barbar.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icons
		},
	})
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use({
		"andweeb/presence.nvim",
		config = function()
			require("presence"):setup({
				buttons = false,
			})
		end,
	})
	-- use({ "L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*" })
	use("rafamadriz/friendly-snippets")
end)
-- Theme Setup
-- vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
-- require("catppuccin").setup()
-- vim.cmd [[colorscheme catppuccin]]
vim.cmd("colorscheme nightfox")
require("gitsigns").setup()
--use(lspconfig)
-- Use an on_attach function to only map the following keys
on_attach = function(client)
	client.resolved_capabilities.document_formatting = false
end
--require'lspconfig'.bashls.setup{}
local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}
require("lspconfig")["pyright"].setup({
	flags = lsp_flags,
})
require("lspconfig")["tsserver"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})
require("lspconfig").tailwindcss.setup({
	on_attach = on_attach,
	flags = lsp_flags,
	filetypes = { "html", "vue", "typescriptreact", "javascriptreact" },
})
require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.prettier,
		--require("null-ls").builtins.diagnostics.eslint,
		--require("null-ls").builtins.completion.spell,
	},
})

-- empty setup using defaults
require("nvim-tree").setup()
-- Comment
require("Comment").setup()
-- Statusline
require("lualine").setup()
-- Luasnip
require("luasnip.loaders.from_vscode").lazy_load()
