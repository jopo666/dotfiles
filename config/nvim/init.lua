---@diagnostic disable: need-check-nil, undefined-field, missing-fields
-------------------- OPTIONS --------------------

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd([[ cabbrev W w ]])
vim.cmd([[ cabbrev E w ]])
vim.cmd([[ cabbrev Q q ]])
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
vim.opt.termguicolors = false -- better colors
vim.opt.swapfile = false -- no swapfiles
vim.opt.tabstop = 4 -- tab width
vim.opt.undofile = true -- persistent undo
vim.opt.virtualedit = "block" -- move outside of text
vim.opt.wildmode = "longest:full,full" -- cmd completion mode

vim.diagnostic.config({ virtual_text = true })
-------------------- KEYMAPS --------------------

-- Easy exit
vim.keymap.set("i", "jk", "<esc>")

-- I'm clumsy...
vim.keymap.set("i", "<c-u>", "<nop>", { silent = true })
vim.keymap.set({ "i", "n", "v", "t" }, "<home>", "<nop>")
vim.keymap.set({ "i", "n", "v", "t" }, "<end>", "<nop>")
vim.keymap.set({ "i", "n", "v", "t" }, "<pageup>", "<nop>")
vim.keymap.set({ "i", "n", "v", "t" }, "<pagedown>", "<nop>")

-- Exit the terminal.
vim.keymap.set("t", "<esc>", "<C-\\><C-n>", { silent = true })
vim.keymap.set("t", "jk", "<C-\\><C-n>", { silent = true })

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
vim.keymap.set("v", "<c-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<c-k>", ":m '<-2<CR>gv=gv")

-- Don't yank when pasting in visual mode
vim.keymap.set("x", "p", [["_dp]])
vim.keymap.set("x", "P", [["_dP]])

-- Toggle stuff
vim.keymap.set("n", "gts", "<cmd>set spell!<cr>", { desc = "Toggle spell" })
vim.keymap.set("n", "gtw", "<cmd>set wrap!<cr>", { desc = "Toggle wrap" })
vim.keymap.set("n", "gtl", "<cmd>set list!<cr>", { desc = "Toggle list" })
vim.keymap.set("n", "gtq", function()
	for _, win in pairs(vim.fn.getwininfo()) do
		if win.quickfix == 1 then
			return vim.cmd("cclose")
		end
	end
	vim.cmd("copen")
	vim.cmd("wincmd p")
end, { desc = "Toggle quickfix" })

-- Clear highlights
vim.keymap.set("n", "<c-c>", "<cmd>nohlsearch<cr>", { desc = "Clear highlights" })

-- Grep motion/selection
vim.keymap.set("n", "gs", function()
	vim.cmd('normal! "xyiw')
	vim.cmd('silent grep! "\\<' .. vim.fn.getreg("x") .. '\\>" **/*')
	vim.cmd("copen")
	vim.cmd("wincmd p")
end, { desc = "Grep cword", silent = true, expr = false })

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

-------------------- AUTOCOMMANDS --------------------

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	callback = function()
		local cursor_pos = vim.api.nvim_win_get_cursor(0)
		vim.cmd([[ %s/\s\+$//e ]])
		vim.api.nvim_win_set_cursor(0, cursor_pos)
	end,
})

-- Don't continue comments
vim.api.nvim_create_autocmd({ "FileType" }, {
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
		vim.keymap.set("n", ",f", "o# fmt: off\n# fmt: on<esc>", { buffer = true, desc = "fmt: off/on" })
		vim.keymap.set("n", ",t", "mCA # type: ignore<esc>`C", { buffer = true, desc = "type: ignore" })
		vim.keymap.set("n", ",n", "mCA # noqa<esc>`C", { buffer = true, desc = "noqa" })
	end,
})

-------------------- PLUGINS --------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Debug printing
	{
		"andrewferrier/debugprint.nvim",
		opts = {
			keymaps = {
				normal = {
					plain_below = "gpp",
					plain_above = "gPP",
					variable_below = "",
					variable_above = "",
					variable_below_alwaysprompt = "",
					variable_above_alwaysprompt = "",
					surround_plain = "",
					surround_variable = "",
					surround_variable_alwaysprompt = "",
					textobj_below = "gp",
					textobj_above = "gP",
					textobj_surround = "",
					toggle_comment_debug_prints = "",
					delete_debug_prints = "",
				},
				insert = {
					plain = "",
					variable = "",
				},
				visual = {
					variable_below = "gp",
					variable_above = "gP",
				},
			},
			commands = {
				toggle_comment_debug_prints = "",
				delete_debug_prints = "DeleteDebugPrints",
				reset_debug_prints_counter = "",
			},
			move_to_debugline = false,
			display_counter = false,
			display_location = false,
			highlight_line = true,
			print_tag = "[DEBUG]",
		},
	},
	-- File browser
	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup({
				columns = {},
				skip_confirm_for_simple_edits = true,
				keymaps = {
					["g?"] = { "actions.show_help", mode = "n" },
					["<CR>"] = "actions.select",
					["<C-s>"] = { "actions.select", opts = { vertical = true } },
					["<C-h>"] = { "actions.select", opts = { horizontal = true } },
					["<C-t>"] = { "actions.select", opts = { tab = true } },
					["<C-c>"] = { "actions.close", mode = "n" },
					["-"] = { "actions.parent", mode = "n" },
					["gx"] = "actions.open_external",
				},
				use_default_keymaps = false,
				view_options = { show_hidden = true },
			})
			vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Browse files" })
		end,
	},
	-- Substitute
	{
		"gbprod/substitute.nvim",
		opts = {
			highlight_substituted_text = {
				enabled = false,
			},
		},
		keys = {
			{
				"s",
				function()
					require("substitute").operator()
				end,
				noremap = true,
			},
			{
				"ss",
				function()
					require("substitute").line()
				end,
				noremap = true,
			},
			{
				"S",
				function()
					require("substitute").eol()
				end,
				noremap = true,
			},
			{
				"s",
				function()
					require("substitute").visual()
				end,
				mode = "x",
				noremap = true,
			},
		},
	},
	-- Surround
	{ "kylechui/nvim-surround", opts = {} },
	-- Automatic tabs
	{ "tpope/vim-sleuth" },
	-- More textobjects
	{ "echasnovski/mini.ai", opts = {} },
	-- Automatic fstrings
	{ "chrisgrieser/nvim-puppeteer", lazy = true },
	-- Undo tree
	{
		"mbbill/undotree",
		config = function()
			vim.cmd([[ let g:undotree_DiffAutoOpen = 0 ]])
		end,
		keys = { { "gtu", "<cmd>UndotreeToggle<cr>", desc = "Toggle undotree" } },
	},
	-- Linting
	{
		"mfussenegger/nvim-lint",
		event = "BufWritePost",
		init = function()
			vim.g.disable_lint = false
		end,
		config = function()
			require("lint").linters_by_ft = {
				bash = { "shellcheck" },
				go = { "golangcilint" },
				html = { "htmlhint" },
				json = { "jsonlint" },
				dockerfile = { "hadolint" },
				proto = { "buf_lint" },
				sh = { "shellcheck" },
			}
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					if not vim.g.disable_lint then
						require("lint").try_lint()
					end
				end,
			})
		end,
		keys = {
			{
				"gtl",
				function()
					vim.g.disable_lint = not vim.g.disable_lint
				end,
				desc = "Toggle lint",
			},
		},
	},
	-- Tests
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-go",
			"nvim-neotest/neotest-python",
			"lawrence-laz/neotest-zig",
		},
		config = function()
			local nt = require("neotest")
			nt.setup({
				adapters = {
					require("neotest-go"),
					require("neotest-python"),
					require("neotest-zig")({ dap = { adapter = "codelldb" } }),
				},
			})
			-- Close results with Q
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "neotest-output", "neotest-output-panel" },
				callback = function()
					vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>close!<cr>", { noremap = true, silent = true })
				end,
			})
		end,
		keys = {
			{
				"<leader>tt",
				function()
					require("neotest").run.run()
				end,
				desc = "Run nearest",
			},
			{
				"<leader>tf",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "Run file",
			},
			{
				"<leader>tk",
				function()
					require("neotest").run.stop()
				end,
				desc = "Kill test",
			},
			{
				"<leader>tr",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "Toggle panel",
			},
			{
				"<leader>to",
				function()
					require("neotest").output.open({ enter = true })
				end,
				desc = "Toggle results",
			},
			{
				"<leader>ts",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "Toggle summary",
			},
		},
	},
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		lazy = vim.fn.argc(-1) == 0,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = false,
				ensure_installed = {
					"bash",
					"gitcommit",
					"go",
					"gomod",
					"gowork",
					"html",
					"lua",
					"json",
					"proto",
					"python",
					"zig",
				},
				highlight = { enable = true },
				indent = { enable = true },
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["as"] = "@struct.outer",
							["is"] = "@struct.inner",
							["at"] = "@type.outer",
							["it"] = "@type.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]f"] = "@function.outer",
							["]c"] = "@class.outer",
							["]s"] = "@struct.outer",
						},
						goto_previous_start = {
							["[f"] = "@function.outer",
							["[c"] = "@class.outer",
							["[s"] = "@struct.outer",
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["]a"] = "@parameter.inner",
						},
						swap_previous = {
							["[a"] = "@parameter.inner",
						},
					},
				},
			})
			require("treesitter-context").setup({
				max_lines = 4,
				multiline_threshold = 1,
				trim_scope = "outer",
			})
			require("treesitter-context").disable()
			vim.keymap.set("n", "gtc", function()
				require("treesitter-context").toggle()
			end, { desc = "Toggle context" })
		end,
	},
	-- Tmux and window movement
	{
		"christoomey/vim-tmux-navigator",
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
		},
	},
	-- Align text
	{
		"echasnovski/mini.align",
		opts = {
			mappings = {
				start_with_preview = "ga",
			},
		},
	},
	-- -- Colorscheme
	-- {
	-- 	"sainnhe/gruvbox-material",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.g.gruvbox_material_background = "hard"
	-- 		vim.g.gruvbox_material_better_performance = true
	-- 		vim.g.gruvbox_material_disable_italic_comment = false
	-- 		vim.cmd([[ colorscheme gruvbox-material ]])
	-- 	end,
	-- },
	-- Buffer manager
	{
		"j-morano/buffer_manager.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		keys = {
			{
				"<leader>b",
				function()
					require("buffer_manager.ui").toggle_quick_menu()
				end,
				desc = "Buffer manager",
			},
		},
	},
	-- Gitsigns
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "x" },
				topdelete = { text = "x" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "x" },
				topdelete = { text = "x" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			preview_config = {
				border = "none",
			},
			current_line_blame_opts = {
				delay = 0,
				virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
			},
		},
		keys = {
			{ "]h", "<cmd>Gitsigns nav_hunk next<cr>", desc = "Next hunk" },
			{ "[h", "<cmd>Gitsigns nav_hunk prev<cr>", desc = "Previous hunk" },
			{ "]H", "<cmd>Gitsigns nav_hunk last<cr>", desc = "Last hunk" },
			{ "[H", "<cmd>Gitsigns nav_hunk first<cr>", desc = "First hunk" },
			{ "gtb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle line blame" },
			{ "gtd", "<cmd>Gitsigns toggle_word_diff<cr>", desc = "Toggle word diff" },
			{ "gtg", "<cmd>Gitsigns toggle_signs<cr>", desc = "Toggle diff signs" },
			{ "<leader>hd", "<cmd>vert Gitsigns diffthis<cr>", desc = "Diff buffer" },
			{ "<leader>hb", "<cmd>Gitsigns blame<cr>", desc = "Show git blame" },
			{ "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", mode = { "n", "v" }, desc = "Stage hunk" },
			{ "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", mode = { "n", "v" }, desc = "Reset hunk" },
		},
	},
	-- Searching
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		cmd = "Telescope",
		opts = {
			defaults = {
				sorting_strategy = "ascending",
				layout_strategy = "center",
				border = false,
				preview = false,
				prompt_title = false,
				prompt_prefix = ">> ",
				results_title = false,
			},
			pickers = {
				find_files = { layout_config = { height = 20, width = 80 } },
				live_grep = { layout_config = { height = 100000, width = 100000 } },
			},
		},
		keys = {
			{ "<c-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<c-g>", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
		},
	},
	-- Formatting
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		cmd = { "ConformInfo" },
		init = function()
			vim.g.disable_autoformat = false
		end,
		opts = {
			notify_on_error = false,
			formatters_by_ft = {
				bash = { "shfmt" },
				buf = { "buf" },
				go = { "goimports", "gofumpt" },
				dockerls = { lsp_format = "fallback" },
				json = { "prettierd" },
				lua = { "stylua" },
				markdown = { "prettierd" },
				python = { "ruff_organize_imports", "ruff_format" },
				sh = { "shfmt" },
				yaml = { "prettierd" },
				toml = { lsp_format = "fallback" },
				zig = { lsp_format = "fallback" },
			},
			format_on_save = function(bufnr)
				local ignore_filetypes = { "json" }
				local bufname = vim.api.nvim_buf_get_name(bufnr)
				if
					vim.g.disable_autoformat
					or vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype)
					or bufname:match("/node_modules/")
					or bufname:match("/dist-packages/")
				then
					return
				end
				return {}
			end,
		},
		keys = {
			{
				"gtf",
				function()
					vim.g.disable_autoformat = not vim.g.disable_autoformat
				end,
				desc = "Toggle auto format",
			},
		},
	},
	-- Completion
	{
		"saghen/blink.cmp",
		version = "1.*",
		opts = {
			keymap = {
				preset = "none",
				["<c-p>"] = { "select_prev", "fallback_to_mappings" },
				["<c-n>"] = { "select_next", "fallback_to_mappings" },
				["<c-u>"] = { "scroll_documentation_up", "fallback" },
				["<c-d>"] = { "scroll_documentation_down", "fallback" },
				["<tab>"] = { "snippet_forward", "fallback" },
				["<s-Tab>"] = { "snippet_backward", "fallback" },
				["<c-y>"] = { "select_and_accept" },
				["<c-k>"] = { "show_signature", "hide_signature", "fallback" },
				["<c-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<c-s>"] = { "show_signature", "hide_signature", "fallback" },
				["<c-e>"] = { "hide" },
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
		},
		cmdline = {
			enabled = true,
		},
		signature = {
			enabled = true,
		},
		opts_extend = { "sources.default" },
	},
	-- Language servers
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		dependencies = { "folke/lazydev.nvim", opts = {}, ft = "lua" },
		config = function()
			-- Setup servers.
			for server_name, opts in pairs({
				["asm_lsp"] = {},
				["buf_ls"] = {},
				["csharp_ls"] = {},
				["dockerls"] = {},
				["gopls"] = {},
				["lua_ls"] = {},
				["pyright"] = {},
				["ruff"] = {},
				["zls"] = {},
			}) do
				require("lspconfig")[server_name].setup(opts)
			end
			-- Setup keybinds.
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(key, act, desc)
						vim.keymap.set("n", key, act, { buffer = event.buf, desc = desc })
					end
					map("gd", vim.lsp.buf.definition, "Goto definition")
					map("gh", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
					end, "Toggle hints")
				end,
			})
		end,
	},
	-- Tools
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		cmd = { "Mason", "MasonToolsInstall" },
		dependencies = {
			{ "williamboman/mason.nvim", opts = {} },
		},
		opts = {
			auto_update = false,
			run_on_start = false,
			ensure_installed = {
				-- Language servers
				"buf-language-server",
				"dockerfile-language-server",
				"gopls",
				"lua-language-server",
				"pyright",
				"ruff",
				-- Linters.
				"buf",
				"golangci-lint",
				"hadolint",
				"jsonlint",
				"htmlhint",
				"shellcheck",
				-- Formatters.
				"gofumpt",
				"goimports",
				"prettierd",
				"shfmt",
				-- Debug adapters.
				"debugpy",
				"codelldb",
				"delve",
			},
		},
	},
	-- Debugging
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{ "theHamsta/nvim-dap-virtual-text", opts = { enabled = false } },
			{ "leoluz/nvim-dap-go", opts = {} },
			{ "mfussenegger/nvim-dap-python", config = function() end },
			{
				"rcarriga/nvim-dap-ui",
				dependencies = { "nvim-neotest/nvim-nio" },
				opts = {
					controls = { enabled = true },
					floating = { border = "none" },
					layouts = {
						{
							elements = {
								{ id = "repl", size = 0.75 },
								{ id = "scopes", size = 0.25 },
							},
							position = "bottom",
							size = 10,
						},
					},
				},
			},
		},
		config = function()
			local dap = require("dap")
			vim.fn.sign_define("DapStopped", { text = ">", texthl = "WarningMsg", linehl = "", numhl = "WarningMsg" })
			-- Setup adapters
			require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
			require("dap-python").test_runner = "pytest"
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = { command = "codelldb", args = { "--port", "${port}" } },
			}
			dap.configurations.zig = {
				{
					name = "Launch",
					type = "codelldb",
					request = "launch",
					program = "${workspaceFolder}/zig-out/bin/${workspaceFolderBasename}",
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
				},
			}
			-- Close previews with q
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "dap-float",
				callback = function()
					vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>close!<cr>", { noremap = true, silent = true })
				end,
			})
		end,
		keys = {
			{
				"<leader>dB",
				function()
					require("dap").set_breakpoint(vim.fn.input("Condition: "))
				end,
				desc = "Conditional breakpoint",
			},
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle breakpoint",
			},
			{
				"<leader>dq",
				function()
					require("dap").list_breakpoints(true)
				end,
				desc = "List breakpoints",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Run/Continue",
			},
			{
				"<leader>dn",
				function()
					require("dap").step_over()
				end,
				desc = "Step over",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "Step into",
			},
			{
				"<leader>do",
				function()
					require("dap").step_out()
				end,
				desc = "Step out",
			},
			{
				"<leader>dr",
				function()
					require("dap").run_to_cursor()
				end,
				desc = "Run to Cursor",
			},
			{
				"<leader>dL",
				function()
					require("dap").run_last()
				end,
				desc = "Run last",
			},
			{
				"<leader>dd",
				function()
					require("dap").repl.toggle()
				end,
				desc = "Toggle REPL",
			},
			{
				"<leader>dk",
				function()
					require("dap").terminate()
				end,
				desc = "Kill",
			},
			{
				"<leader>dv",
				function()
					require("nvim-dap-virtual-text").toggle()
				end,
				desc = "Toggle virtual text",
			},
			{
				"<leader>du",
				function()
					require("dapui").toggle({})
				end,
				desc = "Toggle UI",
			},
			{
				"<leader>dl",
				function()
					require("dapui").float_element("console", {})
				end,
				desc = "Show console",
			},
			{
				"<leader>de",
				function()
					require("dap.ui.widgets").hover()
				end,
				desc = "Evaluate",
			},
			{
				"<leader>df",
				function()
					local widgets = require("dap.ui.widgets")
					widgets.centered_float(widgets.frames)
				end,
				desc = "Frames",
			},
			{
				"<leader>ds",
				function()
					local widgets = require("dap.ui.widgets")
					widgets.centered_float(widgets.scopes)
				end,
				desc = "Scopes",
			},
			{
				"<leader>dt",
				function()
					if vim.bo.filetype == "python" then
						require("dap-python").test_method({ config = { justMyCode = false } })
					elseif vim.bo.filetype == "go" then
						require("dap-go").debug_test()
					elseif vim.bo.filetype == "zig" then
						require("neotest").run.run({ strategy = "dap" })
					else
						print("No test runner for filetype: " .. vim.bo.filetype)
					end
				end,
				desc = "Debug test",
			},
		},
	},
})
