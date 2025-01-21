-- Commit messages
vim.api.nvim_create_autocmd("FileType", {
	pattern = "gitcommit",
	callback = function()
		vim.opt_local.colorcolumn = "50,72"
		vim.opt_local.textwidth = 72
		vim.opt_local.spell = true
	end,
})

-- Text files
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "text", "markdown" },
	callback = function()
		vim.opt_local.colorcolumn = "80"
		vim.opt_local.textwidth = 80
		vim.opt_local.spell = true
	end,
})

-- Python
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.opt_local.colorcolumn = "88"
		vim.keymap.set("n", ",F", "o# fmt: off\n# fmt: on<esc>", { buffer = true, desc = "fmt: off/on" })
		vim.keymap.set("n", ",f", 'mCF"if<esc>`C', { buffer = true, desc = "f-string" })
		vim.keymap.set("n", ",t", "mCA # type: ignore<esc>`C", { buffer = true, desc = "type: ignore" })
		vim.keymap.set("n", ",n", "mCA # noqa<esc>`C", { buffer = true, desc = "noqa" })
	end,
})

-- Lua
vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	callback = function()
		vim.opt_local.colorcolumn = "120"
		vim.keymap.set(
			"n",
			",f",
			"o-- stylua: ignore start\n-- stylua: ignore end<esc>",
			{ buffer = true, desc = "fmt: off/on" }
		)
	end,
})

-- Zig
vim.api.nvim_create_autocmd("FileType", {
	pattern = "zig",
	callback = function()
		vim.keymap.set("n", ",;", "mCA;<esc>`C", { buffer = true, desc = "add semicolon" })
		vim.keymap.set(
			"n",
			",d",
			'yiwostd.debug.print(">>> <c-r>": {any}\\n", .{<c-r>"});<esc>',
			{ buffer = true, desc = "debug print" }
		)
	end,
})
