return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			persist_mode = false,
			size = 20,
			direction = "float",
			float_opts = {
				border = "single",
			},
		},
		config = function(_, opts)
			require("toggleterm").setup(opts)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "toggleterm",
				callback = function()
					vim.opt_local.cursorline = false
					vim.opt_local.laststatus = 0
					vim.opt_local.signcolumn = "yes:1"
				end,
			})
			vim.cmd([[
				command Z wa | qa
				cabbrev wqa Z

			]])
		end,
		keys = {
			{ "<c-s>", "<cmd>ToggleTerm<cr>", mode = { "n", "t" } },
		},
	},
}
