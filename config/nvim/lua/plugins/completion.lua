return {
	{
		"saghen/blink.cmp",
		version = "v0.*",
		event = { "CmdlineEnter", "InsertEnter" },
		opts = {
			cmdline = {
				enabled = true,
			},
			completion = {
				accept = {
					auto_brackets = {
						enabled = false,
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 1000,
				},
			},
			sources = {
				default = {
					"lsp",
					"snippets",
					"path",
					"buffer",
				},
			},
			signature = {
				enabled = true,
			},
			keymap = {
				preset = "none",
				["<c-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<c-s>"] = { "show_signature", "hide_signature", "fallback" },
				["<c-e>"] = { "hide" },
				["<c-y>"] = { "select_and_accept" },
				["<c-j>"] = { "snippet_forward", "fallback" },
				["<c-k>"] = { "snippet_backward", "fallback" },
				["<c-p>"] = { "select_prev", "fallback_to_mappings" },
				["<c-n>"] = { "select_next", "fallback_to_mappings" },
				["<c-d>"] = { "scroll_documentation_up", "fallback" },
				["<c-u>"] = { "scroll_documentation_down", "fallback" },
			},
		},
	},
}
