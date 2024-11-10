---@diagnostic disable: lowercase-global
require("utils")

PLUGINS_TBL = {}
function import(item)
  table.insert(PLUGINS_TBL, { import = item })
end
--
-- add LazyVim and import its plugins
table.insert(PLUGINS_TBL, { "LazyVim/LazyVim", import = "lazyvim.plugins" })

if vim.g.vscode then
  -- config & plugins for vscode
  -- https://github.com/vscode-neovim/vscode-neovim
  import("lazyvim.plugins.extras.vscode")
  import("vscode_neovim.plugins")
  require("vscode_neovim.config.options")
else
  -- Normal LazyVim in neovim
  import("plugins")
end

require("config.lazy")
