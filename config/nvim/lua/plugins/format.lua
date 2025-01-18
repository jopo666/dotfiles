return {
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
				"<leader>f",
				function()
					require("conform").format({ lsp_format = "fallback" })
				end,
				desc = "Format buffer",
			},
			{
				"gtf",
				function()
					vim.g.disable_autoformat = not vim.g.disable_autoformat
				end,
				desc = "Toggle auto format",
			},
		},
	},
}
