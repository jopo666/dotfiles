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
    pattern = { "text", "markdown" },
    callback = function()
        vim.opt_local.colorcolumn = "72"
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- Python
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.opt_local.colorcolumn = "88"
    end,
})

-- Go
vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
        vim.keymap.set("n", ",e", "oif err != nil {<cr>}<esc>Oreturn err<Esc>", { buffer = true })
    end,
})


-- Zig
vim.api.nvim_create_autocmd("FileType", {
    pattern = "zig",
    callback = function()
        vim.keymap.set("n", ",;", "mCA;<esc>`C", { buffer = true })
        vim.keymap.set("n", ",d", 'ostd.debug.print(">>> <c-r>": {any}\\n", .{<c-r>"});<esc>', { buffer = true })
        local simd_loop = function()
            local simd_loop_zig = string.format([[
// Hints for the compiler.
assert(ITERABLE.len > 0);
assert(ITERABLE.len % LENGTH != 0);
assert(ITERABLE.len >= LENGTH * 4);

// Cursor into data.
var cursor = ITERABLE[0..];
while (true) {
    inline for (0..4) |_| {
        const chunk: @Vector(LENGTH, DTYPE) = cursor[0..LENGTH].*;
        // Process chunk.
        const result: [LENGTH]DTYPE = chunk;
        // Update results and cursor.
        cursor[0..LENGTH].* = result;
        cursor = cursor[LENGTH..];
    }
    if (cursor.len == 0) break;
}
]])
            vim.api.nvim_put({ simd_loop_zig }, 'l', true, true)
        end
        vim.keymap.set("n", ",l", simd_loop, { buffer = true })
    end,
})
