return {
	{
		"aaronik/treewalker.nvim",
		opts = { highlight_duration = 100 },
		keys = {
			{ "<up>", "<cmd>Treewalker Up<cr>" },
			{ "<down>", "<cmd>Treewalker Down<cr>" },
			{ "<left>", "<cmd>Treewalker Left<cr>" },
			{ "<right>", "<cmd>Treewalker Right<cr>" },
			{ "[A", "<cmd>Treewalker SwapUp<cr>" },
			{ "]A", "<cmd>Treewalker SwapDown<cr>" },
			{ "[a", "<cmd>Treewalker SwapLeft<cr>" },
			{ "]a", "<cmd>Treewalker SwapRight<cr>" },
		},
	},
}
