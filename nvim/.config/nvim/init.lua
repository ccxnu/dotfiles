require("config")

-- Plugins
require("plugin.oil")
require("plugin.persistence")
require("plugin.dashboard")
require("plugin.harp")
require("plugin.fzf")
require("plugin.lsp")
require("plugin.cmp")
require("plugin.treesitter")
require("plugin.vimtex")

-- Configs
require("keymap")
require("autocmd")

-- Colorscheme
vim.opt.runtimepath:append(vim.fn.expand("$HOME") .. "/Dev/rosebones")
vim.cmd.colorscheme("rosebones")
