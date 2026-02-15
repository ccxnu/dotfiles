vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp", event = "InsertEnter" },
})

require("blink.cmp").setup({
	fuzzy = {
		implementation = "lua", -- Forces use of the Lua implementation, silencing the warning.
	},
	completion = {
		accept = {
			auto_brackets = {
				enabled = false,
			},
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},
	},
	keymap = {
		preset = "none",
		["<C-p>"] = { "select_prev", "show" },
		["<C-n>"] = { "select_next" },
		["<C-d>"] = { "scroll_documentation_down", "fallback" },
		["<C-U>"] = { "scroll_documentation_up", "fallback" },
		["<C-space>"] = { "show" },
		["<CR>"] = { "accept", "fallback" }, -- confirma y hace <Enter>
	},

	cmdline = { enabled = false },

	signature = { enabled = true },

	sources = { default = { "lsp", "path", "snippets" } },

	snippets = { preset = "default" },
})
