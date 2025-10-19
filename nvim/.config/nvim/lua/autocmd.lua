--- Autocmds
local au = vim.api.nvim_create_autocmd
local function ag(name)
	return vim.api.nvim_create_augroup("nvimtraap_" .. name, { clear = true })
end
local map = vim.keymap.set

--- Highlight on yank
au("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Enable Spell on txt, tex, md, vim, and sh files
au("BufEnter", {
	pattern = { "*.txt", "*.tex", "*.bib", "*.md" },
	callback = function()
		vim.opt_local.spell = true
	end,
})

au("FileType", {
	pattern = { "html", "json", "css", "xml" },
	group = ag("indent_settings"),
	callback = function(e)
		vim.bo[e.buf].shiftwidth = 2
		vim.bo[e.buf].tabstop = 2
	end,
})

-- Don't auto commenting new lines
au("BufEnter", { command = [[set formatoptions-=cro]] })

-- Remove WhiteSpace
au("BufWritePre", {
	command = [[%s/\s\+$//e]],
	group = ag("whitespace"),
})

-- Close with q
au({ "FileType" }, {
	pattern = {
		"checkhealth",
		"dap-repl",
		"FzfLua",
		"help",
		"lspinfo",
		"man",
		"nnn",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
	},
	group = ag("close_with_q"),
	callback = function(e)
		vim.bo[e.buf].buflisted = false
		map("n", "q", "<cmd>close!<cr>", { buffer = e.buf, silent = true })
	end,
})

au("LspAttach", {
	group = ag("user_lsp_config"),
	callback = function(e)
		local opts = { buffer = e.buf }
		map("n", "gD", vim.lsp.buf.declaration, opts)
		map("n", "gd", vim.lsp.buf.definition, opts)
		map("n", "<leader>xx", vim.diagnostic.open_float, opts)
	end,
})
