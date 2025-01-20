return {
	{
		"j-morano/buffer_manager.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		keys = {
			{
				"<c-e>",
				function()
					require("buffer_manager.ui").toggle_quick_menu()
				end,
				desc = "Buffer manager",
			},
		},
	},
}
