vim.pack.add({
	{ src = "https://github.com/stevearc/oil.nvim" },
})

local M = {
	keymaps = { ["<Esc>"] = { "actions.close" } },
	delete_to_trash = true,
	skip_confirm_for_simple_edits = true,
	default_file_explorer = true,
	columns = {},
	view_options = {
		show_hidden = true,
		is_hidden_file = function(name, _)
			return vim.startswith(name, ".")
		end,
	},
}

require("oil").setup(M)
