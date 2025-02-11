return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-go",
			"nvim-neotest/neotest-python",
			"lawrence-laz/neotest-zig",
		},
		config = function()
			local nt = require("neotest")
			nt.setup({
				adapters = {
					require("neotest-go"),
					require("neotest-python"),
					require("neotest-zig")({ dap = { adapter = "codelldb" } }),
				},
			})
			-- Close results with Q
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "neotest-output", "neotest-output-panel" },
				callback = function()
					vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>close!<cr>", { noremap = true, silent = true })
				end,
			})
		end,
		keys = {
			-- stylua: ignore start
			{ "<leader>tt", function() require("neotest").run.run() end, desc = "Run nearest" },
			{ "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file" },
			{ "<leader>tk", function() require("neotest").run.stop() end, desc = "Kill test" },
			{ "<leader>tr", function() require("neotest").output_panel.toggle() end, desc = "Toggle panel" },
			{ "<leader>to", function() require("neotest").output.open({enter = true}) end, desc = "Toggle results" },
			{ "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle summary" },
			-- stylua: ignore end
		},
	},
}
