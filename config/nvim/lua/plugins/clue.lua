return {
	{
		"echasnovski/mini.clue",
		config = function()
			require("mini.clue").setup({
				window = { delay = 400 },
				triggers = {
					{ mode = "n", keys = "<leader>" },
					{ mode = "x", keys = "<leader>" },
					{ mode = "n", keys = "g" },
					{ mode = "n", keys = "[" },
					{ mode = "n", keys = "]" },
					{ mode = "n", keys = "," },
				},
				clues = {
					{ mode = "n", keys = "<leader>d", desc = "Debug..." },
					{ mode = "n", keys = "<leader>t", desc = "Test..." },
					{ mode = "n", keys = "<leader>h", desc = "Hunk..." },
					{ mode = "n", keys = "<leader>a", desc = "AI..." },
					{ mode = "n", keys = "gt", desc = "Toggle..." },
				},
			})
		end,
	},
}
