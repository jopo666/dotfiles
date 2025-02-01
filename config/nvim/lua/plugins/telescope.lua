return {
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
				layout_config = {
					height = 30,
					width = 120,
				},
				border = true,
				borderchars = {
					prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					results = { "─", "│", "─", "│", "│", "│", "┘", "└" },
					preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				},
				preview = false,
				prompt_title = false,
				prompt_prefix = " ",
				results_title = false,
			},
			pickers = {
				find_files = { layout_config = { height = 20, width = 80 } },
			},
		},
		keys = {
			{ "<c-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>g", "<cmd>Telescope live_grep preview=false<cr>", desc = "Live grep" },
			{ "<leader>s", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Find symbols" },
			{ "<leader>?", "<cmd>Telescope keymaps<cr>", desc = "Search keymaps" },
		},
	},
}
