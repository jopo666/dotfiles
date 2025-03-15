return {
	{ "folke/lazydev.nvim", opts = {}, ft = "lua" },
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		config = function()
			-- Setup servers.
			for server_name, opts in pairs({
				["asm_lsp"] = {},
				["buf_ls"] = {},
				["dockerls"] = {},
				["gopls"] = {},
				["lua_ls"] = {},
				["pyright"] = {},
				["ruff"] = {},
				["zls"] = {},
			}) do
				require("lspconfig")[server_name].setup(opts)
			end
			-- Setup keybinds.
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(key, act, desc)
						vim.keymap.set("n", key, act, { buffer = event.buf, desc = desc })
					end
					map("gD", vim.lsp.buf.declaration, "Goto declaration")
					map("gd", vim.lsp.buf.definition, "Goto definition")
					map("gr", vim.lsp.buf.references, "Show references")
					map("gI", vim.lsp.buf.implementation, "Goto implementation")
					map("gT", vim.lsp.buf.type_definition, "Goto type definition")
					map("gA", vim.lsp.buf.code_action, "Code action")
					map("ge", vim.lsp.buf.rename, "Rename variable")
					map("K", vim.lsp.buf.hover, "Hover")
					map("gh", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
					end, "Toggle hints")
				end,
			})
		end,
	},
}
