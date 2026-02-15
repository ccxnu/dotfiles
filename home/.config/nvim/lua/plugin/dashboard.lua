local logo = [[
   |\      _,,,---,,_
ZZZzz /,`.-'`'    -.  ;-;;,_
     |,4-  ) )-,_. ,\ (  `'-'
       '---''(_/--'  `-'\_)  ccxnu
]]

logo = string.rep("\n", 8) .. logo .. "\n\n"

local M = {
	theme = "doom",
	config = {
		header = vim.split(logo, "\n"),
		-- stylua: ignore
		center = {
			{ action = 'FzfLua files', desc = ' Find file', icon = ' ', key = 'f' },
			{ action = 'FzfLua live_grep', desc = ' Find text', icon = ' ', key = 'g' },
			{ action = 'FzfLua oldfiles', desc = ' Recent files', icon = ' ', key = 'r' },
			{ action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
			{ action = 'qa', desc = ' Quit', icon = ' ', key = 'q' },
		},
		footer = function()
			return { "⚡ Neovim ready" }
		end,
	},
}

require("dashboard").setup(M)
