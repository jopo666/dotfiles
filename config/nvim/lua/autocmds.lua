-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	callback = function()
		if vim.bo.filetype ~= "proto" then
			-- Save cursor position
			local cursor_pos = vim.api.nvim_win_get_cursor(0)
			-- Remove trailing whitespace
			vim.cmd([[ %s/\s\+$//e ]])
			-- Restore cursor position
			vim.api.nvim_win_set_cursor(0, cursor_pos)
		end
	end,
})

-- Don't continue comments
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = vim.api.nvim_create_augroup("FormatOptions", { clear = true }),
	pattern = { "*" },
	callback = function()
		vim.opt_local.fo:remove("o")
		vim.opt_local.fo:remove("r")
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
		vim.cmd([[ if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]])
	end,
})

-- Resize on splits on resize
vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		vim.cmd([[ wincmd = ]])
	end,
})

-- Remove autoindent for python files
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = vim.api.nvim_create_augroup("FormatOptions", { clear = true }),
	pattern = { "python" },
	callback = function()
		vim.opt_local.autoindent = false
	end,
})
