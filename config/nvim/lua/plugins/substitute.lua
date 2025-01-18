return {
	{
		"gbprod/substitute.nvim",
		opts = {
			highlight_substituted_text = {
				enabled = false,
			},
		},
		keys = {
			-- stylua: ignore start
			{ "s", function() require("substitute").operator() end, noremap = true },
			{ "ss", function() require("substitute").line() end, noremap = true },
			{ "S", function() require("substitute").eol() end, noremap = true },
			{ "s", function() require("substitute").visual() end, mode = "x", noremap = true },
			-- stylua: ignore end
		},
	},
}
