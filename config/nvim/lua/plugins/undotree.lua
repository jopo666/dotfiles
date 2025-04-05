return {
	{
		"mbbill/undotree",
		config = function()
			vim.cmd([[ let g:undotree_DiffAutoOpen = 0 ]])
		end,
		keys = { { "<leader>u", "gtu", desc = "Toggle undotree" } },
	},
}
