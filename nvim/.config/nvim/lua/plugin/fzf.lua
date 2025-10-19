vim.pack.add({
	{ src = "https://github.com/ibhagwan/fzf-lua", event = "CmdlineEnter" },
})

local M = {
	"default",

	defaults = {
		file_icons = false,
	},
}

require("fzf-lua").setup(M)
