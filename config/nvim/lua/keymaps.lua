-- Easy exit
vim.keymap.set("i", "jk", "<esc>")

-- Moving in insert mode
vim.keymap.set("i", "<c-h>", "<left>", { silent = true })
vim.keymap.set("i", "<c-j>", "<c-o>b", { silent = true })
vim.keymap.set("i", "<c-k>", "<c-o>e<right>", { silent = true })
vim.keymap.set("i", "<c-l>", "<right>", { silent = true })
vim.keymap.set("i", "<c-a>", "<c-o>^", { silent = true })
vim.keymap.set("i", "<c-e>", "<c-o>$", { silent = true })

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- Smart completion in command mode
vim.keymap.set("c", "<c-p>", "<up>")
vim.keymap.set("c", "<c-n>", "<down>")

-- Jump around instead
-- vim.keymap.set("n", "<c-d>", "10j")
-- vim.keymap.set("n", "<c-u>", "10k")

-- Disable pageup/pagedown mappings.
vim.keymap.set({ "i", "n", "v" }, "<pageup>", "<nop>")
vim.keymap.set({ "i", "n", "v" }, "<pagedown>", "<nop>")

-- Don't jump to next search result
vim.keymap.set("n", "*", "m`:keepjumps normal! *``<cr>")
vim.keymap.set("n", "#", "m`:keepjumps normal! #``<cr>")

-- Add lines
vim.keymap.set("n", "]<space>", "mEo<esc>`E", { desc = "Add line below" })
vim.keymap.set("n", "[<space>", "mEO<esc>`E", { desc = "Add line above" })

-- Keep selection when indenting
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Move by visual lines
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Don't yank when pasting in visual mode
vim.keymap.set("x", "p", [["_dp]])
vim.keymap.set("x", "P", [["_dP]])

-- Clear highlights
vim.keymap.set("n", "<c-c>", "<cmd>nohlsearch<cr>", { desc = "Clear highlights" })

-- Switch to last buffer.
vim.keymap.set("n", "<space><space>", "<c-^>", { desc = "Switch buffers" })

-- Rename current word
vim.keymap.set("n", "<leader>r", 'yiw:%s/<c-r>"//g<left><left>', { desc = "Rename cword" })

-- Sort selection
vim.keymap.set("v", "gs", ":sort<cr>", { desc = "Sort selection" })

-- Run make
vim.keymap.set("n", "<leader>m", ":make<cr>", { desc = "Run make" })

-- Make file executable
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<cr>", { desc = "Make file executable" })

-- Quickfix mappings.
vim.keymap.set("n", "<leader>q", function()
    for _, win in pairs(vim.fn.getwininfo()) do
        if win.quickfix == 1 then
            return vim.cmd("cclose")
        end
    end
    vim.cmd("copen")
end, { desc = "Toggle quickfix" })
vim.keymap.set("n", "[Q", "<cmd>cfirst<cr>")
vim.keymap.set("n", "]Q", "<cmd>clast<cr>")
vim.keymap.set("n", "[q", "<cmd>cprev<cr>")
vim.keymap.set("n", "]q", "<cmd>cnext<cr>")

-- Yank to system clipboard.
vim.keymap.set({ "n", "x" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set({ "n", "x" }, "<leader>Y", '"+Y', { desc = "Yank to clipboard" })
vim.keymap.set({ "n", "x" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set({ "n", "x" }, "<leader>P", '"+P', { desc = "Paste from clipboard" })

-- Buffer mappings
vim.keymap.set("n", "<leader>O", function()
    local current = vim.api.nvim_get_current_buf()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if buf ~= current then
            vim.api.nvim_buf_delete(buf, { force = true })
        end
    end
end, { desc = "Close other buffers" })
vim.keymap.set("n", "[B", "<cmd>bfirst<cr>")
vim.keymap.set("n", "]B", "<cmd>blast<cr>")
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>")
vim.keymap.set("n", "]b", "<cmd>bnext<cr>")

-- Tab mappings
vim.keymap.set("n", "<leader>n", ":tabnew<cr>", { desc = "New tab" })
vim.keymap.set("n", "<leader>x", ":tabclose<cr>", { desc = "Close tab" })
vim.keymap.set("n", "<leader>o", ":tabonly<cr>", { desc = "Close other tabs" })
vim.keymap.set("n", "[T", "<cmd>tabfirst<cr>")
vim.keymap.set("n", "]T", "<cmd>tablast<cr>")
vim.keymap.set("n", "[t", "<cmd>tabprevious<cr>")
vim.keymap.set("n", "]t", "<cmd>tabnext<cr>")

-- Diagnostic mappings
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open diagnostic" })
vim.keymap.set("n", "<leader>w", vim.diagnostic.setqflist, { desc = "Quickfix errors" })
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end)
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end)
vim.keymap.set("n", "]e", function() vim.diagnostic.goto_next({ severity = "ERROR" }) end)
vim.keymap.set("n", "[e", function() vim.diagnostic.goto_prev({ severity = "ERROR" }) end)
vim.keymap.set("n", "]w", function() vim.diagnostic.goto_next({ severity = "WARN" }) end)
vim.keymap.set("n", "[w", function() vim.diagnostic.goto_prev({ severity = "WARN" }) end)
