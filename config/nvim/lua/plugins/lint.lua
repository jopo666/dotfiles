return {
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
}
