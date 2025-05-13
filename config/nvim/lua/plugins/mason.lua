return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		cmd = { "Mason", "MasonToolsInstall" },
		dependencies = {
			{ "williamboman/mason.nvim", opts = {} },
		},
		opts = {
			auto_update = false,
			run_on_start = false,
			ensure_installed = {
				-- Language servers
				"buf-language-server",
				"dockerfile-language-server",
				"gopls",
				"lua-language-server",
				"pyright",
				"ruff",
				"zls",
				-- Linters.
				"buf",
				"golangci-lint",
				"hadolint",
				"jsonlint",
				"htmlhint",
				"ruff",
				"shellcheck",
				-- Formatters.
				"gofumpt",
				"goimports",
				"prettierd",
				"shfmt",
				-- Debug adapters.
				"debugpy",
				"codelldb",
				"delve",
			},
		},
	},
}
