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
			auto_insert_mode = true,
		},
		keys = {
			{ "<leader>aa", "<cmd>CopilotChatToggle<cr>", desc = "Toggle chat" },
			{ "<leader>as", "<cmd>CopilotChatStop<cr>", desc = "Stop generation" },
			{ "<leader>ag", "<cmd>CopilotChatCommit<cr>", desc = "Gen: commit message" },
			{ "<leader>ad", "<cmd>CopilotChatDocs<cr>", desc = "Gen: documentation" },
			{ "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "Gen: review" },
			{ "<leader>ao", "<cmd>CopilotChatReview<cr>", desc = "Gen: optimization" },
			{ "<leader>at", "<cmd>CopilotChatReview<cr>", desc = "Gen: tests" },
		},
	},
}
