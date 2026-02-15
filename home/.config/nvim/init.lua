-- OPTIONS
local g = vim.g
local o = vim.opt

g.mapleader = " "
g.maplocalleader = ","

-- Performance
o.updatetime = 200          -- Time (ms) before CursorHold event fires and swap file is written
o.timeoutlen = 300          -- Time (ms) to wait for a key sequence to complete (e.g. <leader>x)
o.undofile = true           -- Save undo history to a file so it persists after closing Neovim
o.undolevels = 1000         -- Maximum number of undo steps
o.swapfile = false          -- Disable swap files (recovery files created during editing)
o.backup = false            -- Disable backup files before overwriting
o.shortmess:append("csI")   -- Suppress: completion messages (c), search count (s), intro screen (I)

--- UI / Visual
o.background = "light"
o.wrap = false              -- Disable line wrapping (long lines extend beyond the screen)
o.number = true             -- Show absolute line numbers
o.cmdheight = 0             -- Hide the command line until it's actually needed
o.laststatus = 3            -- Show a single global statusbar instead of one per window
o.conceallevel = 0          -- Show all characters as-is (no hiding of markdown symbols etc.)
o.signcolumn = "yes"        -- Always show the sign column (used by LSP, git, diagnostics)
o.colorcolumn = "120"       -- Show a vertical guide line at column 120
o.cursorline = true         -- Highlight the line the cursor is on
o.cursorlineopt = "number"  -- Only highlight the line number, not the entire line
o.termguicolors = true      -- Enable 24-bit RGB colors in the terminal
o.list = true               -- Show invisible characters defined in listchars
o.listchars = { space = "·", trail = "⋅", tab = "→ " }

-- Editor behavior
o.expandtab = true          -- Insert spaces when pressing Tab instead of a tab character
o.tabstop = 4               -- How wide a tab character visually appears
o.shiftwidth = 4            -- Number of spaces used for each indentation level
o.softtabstop = 4           -- Number of spaces inserted/deleted when pressing Tab/Backspace
o.mouse = ""                -- Disable mouse support entirely
o.clipboard = "unnamedplus" -- Sync Neovim clipboard with the system clipboard
o.fileencoding = "utf-8"    -- Save files using UTF-8 encoding
o.splitright = true         -- Open vertical splits to the right
o.splitbelow = true         -- Open horizontal splits below
o.completeopt = { "menuone", "noselect", "popup" } -- Completion menu: show even for 1 match, don't auto-select, use popup
-- g.syntastic_auto_jump = 0 -- Don't jump on saving

-- Spelling
-- o.spelllang = { "es", "en" } -- Enable spell checking for Spanish and English
-- o.spell = false              -- Spell checking is off by default (toggle with :set spell)

-- PLUGINS
vim.pack.add({
    { src = "https://github.com/nvimdev/dashboard-nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/folke/persistence.nvim" },
    { src = "https://github.com/christoomey/vim-tmux-navigator" },
    { src = "https://github.com/ibhagwan/fzf-lua" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    -- { src = "https://github.com/lervag/vimtex" },
})

vim.opt.runtimepath:append(vim.fn.expand("$HOME") .. "/Dev/rosebones")
vim.cmd.colorscheme("rosebones")

require("oil").setup()
require("persistence").setup()
require("fzf-lua").setup()
require("plugin.dashboard")
require("mason").setup()
require("nvim-treesitter").setup({
    auto_install = false, -- Autoinstall languages that are not installed
    highlight = {
        disable = { "latex", "cpp", "bash" }, -- list of language that will be disabled
    },
    indent = { enable = false },
})
require("plugin.cmp")

vim.g.tmux_navigator_preserve_zoom = 1

-- g.vimtex_mappings_disable = { ["n"] = { "K" } }
-- g.vimtex_view_method = "zathura"
-- g.vimtex_syntax_enabled = 1

-- LSP
local servers = { "lua_ls", "tinymist" }

local on_init = function(client, _)
    if client:supports_method("textDocument/semanticTokens") then
        client.server_capabilities.semanticTokensProvider = nil
    end
end

vim.lsp.config("*", { on_init = on_init })

-- vim.lsp.config("vtsls", { offset_encoding = "utf-8" })
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

vim.lsp.enable(servers)

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

--- KEYMAPS
local mappings = {
  -- Better indenting
  { "v", "<",          "<gv",              { desc = "Indent Left" } },
  { "v", ">",          ">gv",              { desc = "Indent Right" } },

  -- Clear search highlight
  { { "i", "n" },  "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear Search" } },

  -- No yank on paste
  { "x", "p",          "P",                { desc = "Paste No Yank" } },

  -- Splits
  { "n", "<leader>\\", ":vsplit<CR>",      { desc = "Vertical Split" } },
  { "n", "<leader>-",  ":split<CR>",       { desc = "Horizontal Split" } },
  { "n", "<leader>d",  ":close<CR>",       { desc = "Close Pane" } },

  -- Window navigation
  { "n", "<C-h>",      "<C-w>h",           { desc = "Window Left" } },
  { "n", "<C-j>",      "<C-w>j",           { desc = "Window Down" } },
  { "n", "<C-k>",      "<C-w>k",           { desc = "Window Up" } },
  { "n", "<C-l>",      "<C-w>l",           { desc = "Window Right" } },
  -- Tmux Navigation
  { "n", "<C-h>",      "<cmd>TmuxNavigateLeft<CR>",     { desc = "Navigate Left" } },
  { "n", "<C-j>",      "<cmd>TmuxNavigateDown<CR>",     { desc = "Navigate Down" } },
  { "n", "<C-k>",      "<cmd>TmuxNavigateUp<CR>",       { desc = "Navigate Up" } },
  { "n", "<C-l>",      "<cmd>TmuxNavigateRight<CR>",    { desc = "Navigate Right" } },
  { "n", "<C-\\>",     "<cmd>TmuxNavigatePrevious<CR>", { desc = "Navigate Previous" } },

  -- Explorer
  { "n", "<leader>e",  "<CMD>Oil<CR>",                  { desc = "Explorer" } },

  -- FzfLua
  { "n", ";f",         "<cmd>FzfLua files<CR>",         { desc = "Find Files" } },
  { "n", ";r",         "<cmd>FzfLua live_grep<CR>",     { desc = "Live Grep" } },
  { "n", ";h",         "<cmd>FzfLua oldfiles<CR>",      { desc = "Recent Files" } },
}

local opts = { noremap = true, silent = true }
for _, m in ipairs(mappings) do
  vim.keymap.set(m[1], m[2], m[3], vim.tbl_extend("force", opts, m[4] or {}))
end

--- AUTOCMDS
local au = vim.api.nvim_create_autocmd
local function ag(name)
	return vim.api.nvim_create_augroup("nvimtraap_" .. name, { clear = true })
end

--- Don't auto commenting new lines
au("BufEnter", { command = [[set formatoptions-=cro]] })

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

-- Remove WhiteSpace
au("BufWritePre", {
    command = [[%s/\s\+$//e]],
    group = ag("whitespace"),
})

au("LspAttach", {
    group = ag("user_lsp_config"),
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>xx", vim.diagnostic.open_float, opts)

    end,
})
