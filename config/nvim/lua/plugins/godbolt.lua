return {
	{
		"p00f/godbolt.nvim",
		opts = {
			languages = {
				python = { compiler = "python313", options = {} },
				zig = { compiler = "ztrunk", options = { userArguments = "-O ReleaseFast -mcpu=x86_64" } },
			},
			url = "https://godbolt.org",
			quickfix = {
				enable = true,
				auto_open = true,
			},
		},
		keys = {
			{ "<leader>G", ":'<,'>Godbolt!<cr>", mode = "x", desc = "Godbolt" },
			{ "<leader>G", "<cmd>Godbolt!<cr>", mode = "x", desc = "Godbolt" },
		},
	},
}
