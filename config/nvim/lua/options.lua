vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd([[ cabbrev W w ]])
vim.cmd([[ cabbrev Waq waq ]])

vim.opt.breakindent = true -- indent wrapped lines
vim.opt.colorcolumn = "80" -- show 80 char column
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.cursorline = true -- show current line
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.ignorecase = true -- ignore case
vim.opt.inccommand = "split" -- show also off-screen edits live
vim.opt.mouse = "a" -- disable temporarily with shift
vim.opt.listchars = "tab:┊ ,leadmultispace:┆   ,trail:-,nbsp:+"
vim.opt.number = true -- show line numbers
vim.opt.pumheight = 10 -- max completion items
vim.opt.relativenumber = true -- and relative line numbers
vim.opt.scrolloff = 8 -- always show some context
vim.opt.shiftwidth = 4 -- indent width
vim.opt.list = true -- list whitespace chars
vim.opt.shortmess:append("c") -- don't show completion messages
vim.opt.showmode = false -- don't show mode
vim.opt.signcolumn = "yes:2" -- always show 2.
vim.opt.smartcase = true -- don't ignore case with capitals
vim.opt.softtabstop = 4 -- tab width
vim.opt.splitbelow = true -- horizontal splits below
vim.opt.splitright = true -- vertical splits to the right
vim.opt.swapfile = false -- no swapfiles
vim.opt.tabstop = 4 -- tab width
vim.opt.termguicolors = true -- 24-bit RGB colors
vim.opt.undofile = true -- persistent undo
vim.opt.virtualedit = "block" -- move outside of text
vim.opt.wildmode = "longest:full,full" -- cmd completion mode
