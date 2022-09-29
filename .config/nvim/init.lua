-- Disable standard filexplorer for nvimtree plugin
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
require ("options")
require ("keybinds")
require ("plugins")
