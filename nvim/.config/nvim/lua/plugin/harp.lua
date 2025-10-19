vim.pack.add({
	{ src = "https://github.com/vieitesss/miniharp.nvim" },
})

require("miniharp").setup({
	autoload = false, -- load marks for this cwd on startup (default: true)
	autosave = true, -- save marks for this cwd on exit (default: true)
	show_on_autoload = false, -- show popup list after a successful autoload (default: false)
})
