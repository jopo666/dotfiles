-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    callback = function()
        if vim.bo.filetype ~= "proto" then
            vim.cmd([[ %s/\s\+$//e ]])
        end
    end,
})

-- Don't continue comments with with o
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "*",
    callback = function()
        vim.opt.formatoptions:remove "o"
    end,
})

-- Highlight yanked text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Restore cursor position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    callback = function()
        vim.cmd [[ if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]]
    end,
})

-- Resize on splits on resize
vim.api.nvim_create_autocmd({ "VimResized" }, {
    callback = function()
        vim.cmd [[ wincmd = ]]
    end,
})
