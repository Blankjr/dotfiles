local keymap = vim.api.nvim_set_keymap
-- Save
keymap("n", "<c-s>", ":w<CR>", {})
keymap("i", "<c-s>", "<ESC>:w<CR>a", {})
keymap("v", "<leader>yy", "+yy", {})
local opts = { noremap = true }
-- Fast Escape insert mode
keymap("i", "jj", "<ESC>", {})
-- Mouse
vim.cmd([[set mouse+=a]])
-- Move between splits with CTRL + hjkl
keymap("n", "<c-j>", "<c-w>j", opts)
keymap("n", "<c-h>", "<c-w>h", opts)
keymap("n", "<c-k>", "<c-w>k", opts)
keymap("n", "<c-l>", "<c-w>l", opts)
-- Plugin Keymaps
keymap("n", "<leader>gg", ":LazyGit<CR>", {})
-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", {})
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", {})
keymap("n", "<leader>fb", ":Telescope buffers<CR>", {})
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", {})

--local util = require 'vim.lsp.util'
--local formatting_callback = function(client, bufnr)
--  vim.keymap.set('n', '<leader>bf', function()
--    local params = util.make_formatting_params({})
--    client.request('textDocument/formatting', params, nil, bufnr) 
--  end, {buffer = bufnr})
--end
--
--
-- Null LS Format
keymap("n", "<leader>bf", ":lua vim.lsp.buf.format{ async = true}<CR>", {})
-- Nvim Tree (File Explorer)
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", {})
