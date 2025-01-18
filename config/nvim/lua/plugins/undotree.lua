return {
	{
		"mbbill/undotree",
		config = function()
			vim.cmd([[ let g:undotree_DiffAutoOpen = 0 ]])
		end,
		keys = { { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle undotree" } },
	},
}
