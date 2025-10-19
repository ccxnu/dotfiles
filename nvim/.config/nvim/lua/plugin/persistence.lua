-- Plugins
vim.pack.add({
	{ src = "https://github.com/folke/persistence.nvim" },
})

require("persistence").setup({
	dir = vim.fn.stdpath("state") .. "/sessions/",
})
