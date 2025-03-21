return {
	"andrewferrier/debugprint.nvim",
	opts = {
		keymaps = {
			normal = {
				plain_below = "",
				plain_above = "",
				variable_below = "gp",
				variable_above = "gP",
				variable_below_alwaysprompt = "",
				variable_above_alwaysprompt = "",
				textobj_below = "",
				textobj_above = "",
				toggle_comment_debug_prints = "",
				delete_debug_prints = "",
			},
			insert = {
				plain = "",
				variable = "",
			},
			visual = {
				variable_below = "",
				variable_above = "",
			},
		},
		commands = {
			toggle_comment_debug_prints = "",
			delete_debug_prints = "DeleteDebugPrints",
			reset_debug_prints_counter = "",
		},
		move_to_debugline = false,
		display_counter = false,
		display_location = false,
		highlight_line = true,
		print_tag = "[DEBUG]",
	},
}
