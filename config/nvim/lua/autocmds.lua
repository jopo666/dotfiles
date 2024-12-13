-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    callback = function()
        if vim.bo.filetype ~= "proto" then
            vim.cmd([[ %s/\s\+$//e ]])
        end
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

-- Commit messages
vim.api.nvim_create_autocmd("FileType", {
    pattern = "gitcommit",
    callback = function()
        vim.opt_local.colorcolumn = "50,72"
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- Text files
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "text", "plaintex", "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.colorcolumn = "72"
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- Python
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*.py",
    callback = function()
        vim.wo.colorcolumn = "88"
    end,
})
