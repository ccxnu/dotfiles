local function typst_watch_start()
    local typ_file_path = vim.fn.expand("%:p")
    local cmd = "typst watch " .. vim.fn.shellescape(typ_file_path)
    vim.cmd("sp")
    vim.cmd("resize 7")
    vim.cmd("terminal " .. cmd)

    vim.cmd("wincmd k")
    vim.cmd("setlocal winfixheight")
end

local function zathura_open()
    local pdf_path = vim.fn.expand("%:p:r") .. ".pdf"
    local zathura_cmd = string.format("zathura --fork %s &", vim.fn.shellescape(pdf_path))
    os.execute(zathura_cmd)
end

local function typst_start_live_preview()
    typst_watch_start()
    vim.defer_fn(zathura_open, 500)
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "typst",
    callback = function()
        vim.api.nvim_create_user_command("TypstLivePreview", typst_start_live_preview, { desc = "Start typst watch and open Zathura" })
        vim.keymap.set("n", "<localleader>t", ":TypstLivePreview<CR>", {
            buffer = true,
            silent = true,
            desc = "Typst: Start Live Preview"
        })
    end,
})
