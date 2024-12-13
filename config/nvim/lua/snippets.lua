-- Go error handling.
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*.go",
    callback = function()
        vim.keymap.set("n", ",e", "oif err != nil {<cr>}<esc>Oreturn err<Esc>", { buffer = true })
    end,
})

-- Add semicolon.
vim.keymap.set("n", ",;", "mCA;<esc>`C")
