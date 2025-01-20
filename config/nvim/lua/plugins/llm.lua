return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
		build = "make tiktoken",
		opts = {
			window = {
				layout = "horizontal",
				height = 0.3,
			},
			show_help = false,
			question_header = "#### User ",
			answer_header = "#### Copilot ",
			error_header = "#### Error ",
			separator = "",
			mappings = { show_help = { normal = "g?" } },
		},
		keys = {
			{ "<leader>aa", "<cmd>CopilotChatToggle<cr>", mode = { "n", "x" }, desc = "Toggle chat" },
			{ "<leader>as", "<cmd>CopilotChatStop<cr>", mode = { "n", "x" }, desc = "Stop chat" },
			{ "<leader>ar", "<cmd>CopilotChatReset<cr>", mode = { "n", "x" }, desc = "Reset chat" },
			{ "<leader>ac", "<cmd>CopilotChatCommit<cr>", mode = { "n", "x" }, desc = "Commit message" },
			{ "<leader>at", "<cmd>CopilotChatTests<cr>", mode = { "n", "x" }, desc = "Generate tests" },
		},
	},
}
