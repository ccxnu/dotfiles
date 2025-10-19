vim.pack.add({
	{ src = "https://github.com/lervag/vimtex" },
})

vim.g.vimtex_mappings_disable = { ["n"] = { "K" } }
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_syntax_enabled = 1
-- vim.g.vimtex_quickfix_mode = 0
-- vim.g.vimtex_quickfix_open_on_warning = 0
