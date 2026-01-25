vim.pack.add({
    { src = 'https://github.com/lunacookies/vim-colors-xcode' },
})

-- Colorscheme
-- vim.opt.runtimepath:append(vim.fn.expand("$HOME") .. "/Dev/rosebones")
vim.cmd.colorscheme("xcodelight")

-- Solarized Light background
local bg = '#fdf6e3'

-- Update all white backgrounds
vim.api.nvim_set_hl(0, 'Normal', { bg = bg })
vim.api.nvim_set_hl(0, 'EndOfBuffer', { fg = bg, bg = bg })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = bg })
vim.api.nvim_set_hl(0, 'LineNr', { bg = bg })
vim.api.nvim_set_hl(0, 'FoldColumn', { bg = bg })
vim.api.nvim_set_hl(0, 'VertSplit', { bg = bg })
vim.api.nvim_set_hl(0, 'Cursor', { fg = bg })
