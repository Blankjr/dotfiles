-- General and builtins configs
require("options")
-- Plugin related configs
require("plugins")
-- Commands
require("commands")
-- LSP, Linters and Formatters configs
require("lsp")
-- Keymaps
require("keymaps")

--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
