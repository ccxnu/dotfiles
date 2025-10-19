--- Keymaps
local map = vim.keymap.set

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Correcting spelling mistakes on the fly: https://castel.dev/post/lecture-notes-1/
map("i", "<C-l>", "<C-g>u<Esc>[s1z=`]a<C-g>u")

map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>") -- Clear search
map("x", "p", "P") -- No yank on paste

-- New pane on vertical and close
map("n", "<leader>\\", ":vsplit<CR>")
map("n", "<leader>-", ":split<CR>")
map("n", "<leader>d", ":close<CR>")

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Keymaps
map("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Explorer", noremap = true, silent = true })

map("n", ";f", "<cmd>FzfLua files<CR>")
map("n", ";r", "<cmd>FzfLua live_grep<CR>")
map("n", ";h", "<cmd>FzfLua oldfiles<CR>")

map("n", "<leader>m", require("miniharp").toggle_file)
map("n", "<leader>l", require("miniharp").show_list)
map("n", "<C-n>", require("miniharp").next)
map("n", "<C-p>", require("miniharp").prev)
