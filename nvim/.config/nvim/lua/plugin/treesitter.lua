vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

local M = {
	-- ensure_installed = { "lua", "xml", "http", "json" },
	auto_install = false, -- Autoinstall languages that are not installed
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "latex", "cpp", "bash" }, -- list of language that will be disabled
	},
	indent = { enable = false },
}

require("nvim-treesitter.configs").setup(M)
