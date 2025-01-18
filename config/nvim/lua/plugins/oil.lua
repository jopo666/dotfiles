return {
	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup({
				columns = {},
				skip_confirm_for_simple_edits = false,
				constrain_cursor = "editable",
				keymaps = {
					["g?"] = "actions.show_help",
					["<CR>"] = "actions.select",
					["<C-v>"] = {
						"actions.select",
						opts = { vertical = true },
						desc = "Open the entry in a vertical split",
					},
					["<C-s>"] = {
						"actions.select",
						opts = { horizontal = true },
						desc = "Open the entry in a horizontal split",
					},
					["<C-t>"] = {
						"actions.select",
						opts = { tab = true },
						desc = "Open the entry in new tab",
					},
					["-"] = "actions.parent",
				},
				use_default_keymaps = false,
				view_options = {
					show_hidden = true,
				},
			})
			vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Browse files" })
		end,
	},
}
