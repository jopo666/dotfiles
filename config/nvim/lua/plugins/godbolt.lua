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
			{ "<leader>c", ":'<,'>Godbolt!<cr>", mode = "x", desc = "Godbolt" },
			{ "<leader>c", "<cmd>Godbolt!<cr>", mode = "n", desc = "Godbolt" },
		},
	},
}
