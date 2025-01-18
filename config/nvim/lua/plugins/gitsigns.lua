return {
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
}
