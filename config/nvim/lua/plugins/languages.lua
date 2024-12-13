return {
    -- Zig settings for compiler
    {
        "https://github.com/ziglang/zig.vim",
        config = function()
            vim.g.zig_fmt_autosave = 0 -- Handled by zls
        end
    },
    -- Language servers.
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "folke/neodev.nvim",       opts = {} },
            { "williamboman/mason.nvim", opts = {} },
            {
                "williamboman/mason-lspconfig.nvim",
                opts = {
                    ensure_installed = {
                        "bashls",
                        "buf_ls",
                        "dockerls",
                        "gopls",
                        "html",
                        "jsonls",
                        "lua_ls",
                        "taplo",
                        "yamlls",
                    },
                }
            },
        },
        config = function()
            -- Setup servers.
            require("mason-lspconfig").setup {}
            require("mason-lspconfig").setup_handlers {
                function(server_name)
                    require("lspconfig")[server_name].setup {}
                end,
            }
            -- Setup keybinds.
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
                callback = function(event)
                    vim.keymap.set("n", "<leader>i", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                    end, { buffer = event.buf, desc = "Toggle inlay hints" })
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = event.buf, desc = "Goto declaration" })
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf, desc = "Goto definition" })
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = event.buf, desc = "Show references" })
                    vim.keymap.set("n", "gI", vim.lsp.buf.implementation,
                        { buffer = event.buf, desc = "Goto implementation" })
                    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition,
                        { buffer = event.buf, desc = "Goto type definition" })
                    vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { buffer = event.buf, desc = "Code action" })
                    vim.keymap.set("n", "ge", vim.lsp.buf.rename, { desc = "Rename variable", buffer = event.buf })
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = event.buf, desc = "Hover" })
                end,
            })
        end
    },
    -- Other language tools.
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
            auto_update = true,
            ensure_installed = {
                -- Linters.
                "buf",
                "codespell",
                "eslint_d",
                "golangci-lint",
                "hadolint",
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

            }
        }
    },
    -- Linting.
    {
        "mfussenegger/nvim-lint",
        event = "BufWritePost",
        config = function()
            require("lint").linters_by_ft = {
                bash = { "shellcheck" },
                go = { "golangcilint" },
                html = { "htmlhint" },
                dockerfile = { "hadolint" },
                javascript = { "eslint_d" },
                javascriptreact = { "eslint_d" },
                json = { "jsonlint" },
                proto = { "buf_lint" },
                sh = { "shellcheck" },
                typescript = { "eslint_d" },
                typescriptreact = { "eslint_d" },
            }
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    require("lint").try_lint()
                    require("lint").try_lint("codespell")
                end,
            })
        end,
    },

    -- Formatting
    {
        'stevearc/conform.nvim',
        event = "BufWritePost",
        cmd = { 'ConformInfo' },
        opts = {
            notify_on_error = false,
            formatters_by_ft = {
                bash = { "shfmt" },
                go = { "goimports", "gofumpt" },
                javascript = { "prettierd" },
                javascriptreact = { "prettierd" },
                json = { "prettierd" },
                lua = { "stylua" },
                markdown = { "prettierd" },
                python = { "ruff_organize_imports", "ruff_format" },
                sh = { "shfmt" },
                typescript = { "prettierd" },
                typescriptreact = { "prettierd" },
                yaml = { "prettierd" },
            },
            format_on_save = function(bufnr)
                local bufname = vim.api.nvim_buf_get_name(bufnr)
                if (
                        bufname:match("/node_modules/")
                        or bufname:match("/dist-packages/")
                    ) then
                    return
                end
                return { lsp_fallback = true }
            end,
        },
    },

}
