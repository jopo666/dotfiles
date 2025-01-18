return {
	{
		"saghen/blink.cmp",
		version = "v0.*",
		event = { "CmdlineEnter", "InsertEnter" },
		opts = {
			keymap = { preset = "default" },
			appearance = {
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "snippets", "path", "buffer" },
			},
			signature = { enabled = true },
		},
	},
}
