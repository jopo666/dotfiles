-- Easy exit
vim.keymap.set("i", "jk", "<esc>")

-- Moving in insert mode
vim.keymap.set("i", "<c-h>", "<left>")
vim.keymap.set("i", "<c-l>", "<right>")
vim.keymap.set({ "i", "s" }, "<c-j>", "<c-o>b")
vim.keymap.set({ "i", "s" }, "<c-k>", "<c-o>w")

-- I'm clumsy...
vim.keymap.set("c", "E", "<nop>", { silent = true })
vim.keymap.set("c", "Q", "<nop>", { silent = true })
vim.keymap.set("i", "<c-u>", "<nop>", { silent = true })
vim.keymap.set({ "i", "n", "v", "t" }, "<home>", "<nop>")
vim.keymap.set({ "i", "n", "v", "t" }, "<end>", "<nop>")
vim.keymap.set({ "i", "n", "v", "t" }, "<pageup>", "<nop>")
vim.keymap.set({ "i", "n", "v", "t" }, "<pagedown>", "<nop>")

-- Exit the terminal.
vim.keymap.set("t", "<esc>", "<C-\\><C-n>", { silent = true })
vim.keymap.set("t", "jk", "<C-\\><C-n>", { silent = true })

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- Don't jump to next search result
vim.keymap.set("n", "*", "m`:keepjumps normal! *``<cr>")
vim.keymap.set("n", "#", "m`:keepjumps normal! #``<cr>")

-- Keep selection when indenting
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Move by visual lines
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move text
vim.keymap.set("v", "<down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<up>", ":m '<-2<CR>gv=gv")

-- Don't yank when pasting in visual mode
vim.keymap.set("x", "p", [["_dp]])
vim.keymap.set("x", "P", [["_dP]])

-- Toggle stuff
vim.keymap.set("n", "gts", "<cmd>set spell!<cr>", { desc = "Toggle spell" })
vim.keymap.set("n", "gtw", "<cmd>set wrap!<cr>", { desc = "Toggle wrap" })
vim.keymap.set("n", "gtl", "<cmd>set list!<cr>", { desc = "Toggle list" })

-- Clear highlights
vim.keymap.set("n", "<c-c>", "<cmd>nohlsearch<cr>", { desc = "Clear highlights" })

-- Rename current word
vim.keymap.set("n", "<leader>r", '"xyiw:%s/<c-r>x//g<left><left>', { desc = "Rename cword" })

-- Grep motion/selection
vim.keymap.set("n", "gs", function()
	vim.cmd('normal! "xyiw')
	vim.cmd('silent grep! "\\<' .. vim.fn.getreg("x") .. '\\>" **/*')
	vim.cmd("copen")
	vim.cmd("wincmd p")
end, { desc = "Grep cword", silent = true, expr = false })

-- Run make
vim.keymap.set("n", "<leader>m", ":make<cr>", { desc = "Run make" })

-- Make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<cr>", { desc = "chmod +x" })

-- Quickfix mappings.
vim.keymap.set("n", "gtq", function()
	for _, win in pairs(vim.fn.getwininfo()) do
		if win.quickfix == 1 then
			return vim.cmd("cclose")
		end
	end
	vim.cmd("copen")
	vim.cmd("wincmd p")
end, { desc = "Toggle quickfix" })

-- Yank to system clipboard.
vim.keymap.set({ "n", "x" }, "<leader>y", '"+y', { desc = "Yank (system)" })
vim.keymap.set({ "n", "x" }, "<leader>Y", '"+y$', { desc = "Yank (system)" })
vim.keymap.set({ "n", "x" }, "<leader>p", '"+p', { desc = "Paste (system)" })
vim.keymap.set({ "n", "x" }, "<leader>P", '"+P', { desc = "Paste (system)" })

-- Tab mappings
vim.keymap.set("n", "[T", "<cmd>tabfirst<cr>", { desc = "First tab" })
vim.keymap.set("n", "]T", "<cmd>tablast<cr>", { desc = "Last tab" })
vim.keymap.set("n", "[t", "<cmd>tabprevious<cr>", { desc = "Prev tab" })
vim.keymap.set("n", "]t", "<cmd>tabnext<cr>", { desc = "Next tab" })
