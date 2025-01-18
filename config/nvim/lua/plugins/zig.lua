return {
	{
		"ziglang/zig.vim",
		ft = "zig",
		config = function()
			vim.g.zig_fmt_autosave = 0 -- Handled by zls
		end,
	},
}
