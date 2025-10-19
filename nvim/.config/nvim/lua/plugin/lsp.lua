vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig", event = { "BufReadPost" } },
	{ src = "https://github.com/mason-org/mason.nvim" },
})
-- Lsp
require("mason").setup({})

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	update_in_insert = false,
	underline = true,
	float = {
		show_header = false,
		source = "if_many",
		border = "rounded",
		focusable = false,
	},
})

local servers = { "lua_ls", "gopls", "biome", "texlab", "vtsls" }

local on_init = function(client, _)
	if client:supports_method("textDocument/semanticTokens") then
		client.server_capabilities.semanticTokensProvider = nil
	end
end

vim.lsp.config("*", {
	-- capabilities = capabilities,
	on_init = on_init,
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

vim.lsp.config("vtsls", { offset_encoding = "utf-8" })

vim.lsp.enable(servers)
