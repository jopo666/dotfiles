return {
	{
		"sainnhe/gruvbox-material",
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_better_performance = true
			vim.g.gruvbox_material_disable_italic_comment = false
			vim.cmd([[ colorscheme gruvbox-material ]])
		end,
	},
}
