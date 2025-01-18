return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			defaults = {
				sorting_strategy = "ascending",
				layout_strategy = "bottom_pane",
				layout_config = {
					height = 10,
					preview_cutoff = 20,
					prompt_position = "top",
				},
				border = true,
				borderchars = {
					prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
					results = { " " },
					preview = { " " },
				},
				preview = false,
				prompt_title = false,
				results_title = false,
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
