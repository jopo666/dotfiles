---@diagnostic disable: undefined-global, missing-fields

--- OPTIONS ---
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.breakindent = true    -- indent wrapped lines
vim.opt.colorcolumn = "80"    -- show 80 char column
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.cursorline = true     -- show current line
vim.opt.expandtab = true      -- use spaces instead of tabs
vim.opt.ignorecase = true     -- ignore case
vim.opt.mouse = "a"           -- disable temporarily with shift
vim.opt.number = true         -- show line numbers
vim.opt.pumheight = 10        -- max completion items
vim.opt.relativenumber = true -- and relative line numbers
vim.opt.scrolloff = 8         -- always show some context
vim.opt.shortmess:append("c") -- don't show completion messages
vim.opt.signcolumn = "yes"    -- always show sign column
vim.opt.smartcase = true      -- don't ignore case with capitals
vim.opt.swapfile = false      -- no swapfiles
vim.opt.splitright = true     -- vertical splits to the right
vim.opt.splitbelow = true     -- horizontal splits below
vim.opt.tabstop = 4           -- tab width
vim.opt.shiftwidth = 4        -- indent width
vim.opt.softtabstop = 4       -- tab width
vim.opt.termguicolors = true  -- 24-bit RGB colors
vim.opt.undofile = true       -- persistent undo

--- AUTOCOMMANDS ---
vim.cmd([[ au BufWritePre * :%s/\s\+$//e ]])
vim.cmd([[ au TextYankPost * silent! lua vim.highlight.on_yank() ]])
vim.cmd([[ autocmd BufReadPost *  if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]])
vim.cmd([[ autocmd FileType * set formatoptions-=ro ]])

--- FILETYPES ---
vim.cmd([[ autocmd FileType gitcommit setlocal colorcolumn=50,70 ]])
vim.cmd([[ autocmd FileType lua setlocal colorcolumn=100 ]])
vim.cmd([[ autocmd FileType markdown,gitcommit setlocal spell ]])
vim.cmd([[ autocmd FileType python setlocal colorcolumn=88 ]])

--- KEYMAPS ---
vim.keymap.set("n", ";", ":")
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("i", "<c-h>", "<left>")
vim.keymap.set("i", "<c-j>", "<down>")
vim.keymap.set("i", "<c-k>", "<up>")
vim.keymap.set("i", "<c-l>", "<right>")
vim.keymap.set("c", "<c-p>", "<up>")
vim.keymap.set("c", "<c-n>", "<down>")
vim.keymap.set("n", "<tab>", ":bn<cr>", { desc = "Next buffer", silent = true })
vim.keymap.set("n", "<s-tab>", ":bp<cr>", { desc = "Previous buffer", silent = true })
vim.keymap.set({ "i", "n", "v" }, "<pageup>", "<nop>")
vim.keymap.set({ "i", "n", "v" }, "<pagedown>", "<nop>")
vim.keymap.set("n", "*", "m`:keepjumps normal! *``<cr>")
vim.keymap.set("n", "#", "m`:keepjumps normal! #``<cr>")
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")
vim.keymap.set("n", "<c-s>", "m`:keepjumps normal! *``<cr>cgn")
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("x", "p", [["_dp]])
vim.keymap.set("x", "P", [["_dP]])
vim.keymap.set("n", "[d", vim.diagnostic.goto_next, { desc = "Next error" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, { desc = "Previous error" })
vim.keymap.set("x", "gs", ":sort<cr>", { desc = "Sort selection" })
vim.keymap.set("n", "<space><space>", "<c-^>", { desc = "Switch buffers" })
vim.keymap.set("n", "<leader>q", "<cmd>copen<cr>", { desc = "Open quickfix" })
vim.keymap.set("n", "<leader>x", "<cmd>bd<cr>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<cr>", { desc = "Make file executable" })
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "Clear search" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show error" })
vim.keymap.set("n", "<leader>w", vim.diagnostic.setqflist, { desc = "Quickfix errors" })
vim.keymap.set({ "n", "x" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set({ "n", "x" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })

--- PLUGINS ---
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath, })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "tpope/vim-commentary" },
    { "tpope/vim-repeat" },
    { "tpope/vim-rsi" },
    { "tpope/vim-sleuth" },
    { "tpope/vim-surround" },
    { "tpope/vim-unimpaired" },
    { "wellle/targets.vim" },
    { "windwp/nvim-autopairs", opts = {} },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = { char = "┆" },
            scope = { enabled = false }
        }
    },
    {
        "stevearc/oil.nvim",
        opts = {
            view_options = { show_hidden = true },
        },
        config = function()
            require("oil").setup {
                default_file_explorer = true,
                view_options = { show_hidden = true },
                columns = {},
                keymaps = {
                    ["g?"] = "actions.show_help",
                    ["<CR>"] = "actions.select",
                    ["<C-s>"] = "actions.select_vsplit",
                    ["<C-v>"] = "actions.select_split",
                    ["<C-t>"] = "actions.select_tab",
                    ["<C-c>"] = "actions.close",
                    ["-"] = "actions.parent",
                    ["gx"] = "actions.open_external",
                },
                use_default_keymaps = false,
            }
            vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Explore files" })
        end
    },
    {
        "Wansmer/treesj",
        keys = { { "<leader>j", "<cmd>TSJToggle<cr>", desc = "Join Toggle" } },
        opts = { use_default_keymaps = false, max_join_length = 150 },
    },
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },
    {
        "gbprod/substitute.nvim",
        config = function()
            local substitute = require("substitute")
            substitute.setup({
                highlight_substituted_text = { timer = 100 },
            })
            vim.keymap.set("n", "s", substitute.operator, { desc = "Substitute operator" })
            vim.keymap.set("n", "ss", substitute.line, { desc = "Substitute line" })
            vim.keymap.set("n", "S", substitute.eol, { desc = "Substitute to end of line" })
            vim.keymap.set("x", "s", substitute.visual, { desc = "Substitute visual" })
        end,
    },
    {
        "github/copilot.vim",
        config = function()
            local copilot_on = true
            local togge_copilot = function()
                if copilot_on then
                    vim.cmd("Copilot disable")
                    print("Copilot disabled")
                else
                    vim.cmd("Copilot enable")
                    print("Copilot enabled")
                end
                copilot_on = not copilot_on
            end
            vim.keymap.set("n", "<leader>c", togge_copilot, { desc = "Toggle Copilot" })
        end
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<c-p>",     "<cmd>Telescope find_files theme=dropdown previewer=false<cr>",                desc = "Find files" },
            { "<c-n>",     "<cmd>Telescope buffers theme=dropdown previewer=false<cr>",                   desc = "Find buffers" },
            { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find theme=dropdown previewer=false<cr>", desc = "Fuzzy search" },
            { "<leader>G", "<cmd>Telescope live_grep<cr>",                                                desc = "Live grep" },
            { "<leader>s", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",                            desc = "LSP symbols" },
        }
    },
    {
        "sainnhe/gruvbox-material",
        config = function()
            vim.g.gruvbox_material_background = "soft"
            vim.g.gruvbox_material_better_performance = true
            vim.g.gruvbox_material_disable_italic_comment = true
            vim.cmd [[ colorscheme gruvbox-material ]]
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = { icons_enabled = false, section_separators = "", component_separators = "" },
            sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { { 'buffers', symbols = { modified = '', alternate_file = '', directory = '' } } },
                lualine_x = { "diagnostics", "branch", "diff", "filetype", "location" },
                lualine_y = {},
                lualine_z = {},
            },
        }
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns
                vim.keymap.set("n", "]h", gs.next_hunk, { buffer = bufnr, desc = "Next hunk" })
                vim.keymap.set("n", "[h", gs.prev_hunk, { buffer = bufnr, desc = "Previous hunk" })
                vim.keymap.set("n", "<leader>gs", gs.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
                vim.keymap.set("n", "<leader>gr", gs.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
                vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
                vim.keymap.set("n", "<leader>gd", gs.diffthis, { buffer = bufnr, desc = "Diff buffer" })
            end,
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            -- "nvim-treesitter/nvim-treesitter-context",
        },
        build = ":TSUpdate",
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("nvim-treesitter.configs").setup({
                auto_install = true,
                ensure_installed = {
                    "bash",
                    "go",
                    "html",
                    "javascript",
                    "json",
                    "lua",
                    "markdown",
                    "python",
                    "rust",
                    "toml",
                    "typescript",
                    "vimdoc",
                    "yaml",
                },
                highlight = { enable = true },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["as"] = "@struct.outer",
                            ["is"] = "@struct.inner",
                            ["at"] = "@type.outer",
                            ["it"] = "@type.inner",
                        },
                    },
                },
            })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-path",
            "rcarriga/cmp-dap",
            "rafamadriz/friendly-snippets",
            "saadparwaiz1/cmp_luasnip",
            { "L3MON4D3/LuaSnip", version = "v2.*" },
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                enabled = function()
                    local is_prompt = vim.api.nvim_buf_get_option(0, "buftype") == "prompt"
                    local is_dap = require("cmp_dap").is_dap_buffer()
                    return not is_prompt or is_dap
                end,
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<tab>"] = { i = cmp.config.disable, c = cmp.config.disable },
                    ["<c-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<c-d>"] = cmp.mapping.scroll_docs(4),
                    ["<c-e>"] = cmp.mapping.abort(),
                    ["<c-y>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if luasnip.expandable() then
                                luasnip.expand()
                            else
                                cmp.confirm({ select = true })
                            end
                        else
                            fallback()
                        end
                    end),
                    ["<c-k>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<c-j>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp", index = 1 },
                    { name = "buffer",   index = 2 },
                    { name = "path",     index = 2 },
                    { name = "luasnip",  index = 2 },
                }),
            })
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = { name = "buffer" },
            })
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline({
                    ["<c-n>"] = cmp.config.disable,
                    ["<c-p>"] = cmp.config.disable,
                }),
                sources = cmp.config.sources({
                    { name = "path",    index = 1 },
                    { name = "cmdline", index = 2 },
                }),
            })
            cmp.setup.filetype(
                { "dap-repl", "dapui_watches", "dapui_hover" },
                { sources = { { name = "dap" } } }
            )
            -- Advertise lsp capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend(
                "force",
                capabilities,
                require("cmp_nvim_lsp").default_capabilities()
            )
            -- Snippets
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "folke/neodev.nvim",       opts = {} },
            { "williamboman/mason.nvim", opts = {} },
            {
                "ray-x/lsp_signature.nvim",
                event = "VeryLazy",
                opts = {
                    floating_window = false,
                    hint_enable = false,
                    handler_opts = { border = "shadow" },
                    toggle_key = "<c-s>",
                },
            },
            {
                "williamboman/mason-lspconfig.nvim",
                opts = {
                    ensure_installed = {
                        "bashls",
                        "bufls",
                        "dockerls",
                        "gopls",
                        "html",
                        "jsonls",
                        "lua_ls",
                        "pyright",
                        "ruff_lsp",
                        "taplo",
                        "yamlls",
                        "zls",
                    }
                },
                config = function()
                    require("mason-lspconfig").setup_handlers {
                        function(server_name)
                            require("lspconfig")[server_name].setup {}
                        end,
                    }
                end
            },
            {
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                opts = {
                    auto_update = true,
                    ensure_installed = {
                        "buf",
                        "debugpy",
                        "codespell",
                        "delve",
                        "eslint_d",
                        "gofumpt",
                        "goimports",
                        "golangci-lint",
                        "htmlhint",
                        "prettierd",
                        "shellcheck",
                        "shfmt",
                    }
                }
            }
        },
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
                callback = function(event)
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = event.buf })
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf })
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = event.buf })
                    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = event.buf })
                    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = event.buf })
                    vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { buffer = event.buf })
                    vim.keymap.set("n", "ge", vim.lsp.buf.rename, { buffer = event.buf })
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = event.buf })
                end,
            })
        end
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                bash = { "shfmt" },
                go = { "goimports", "gofumpt" },
                json = { "prettierd" },
                markdown = { "prettierd" },
                javascript = { "prettierd" },
                javascriptreact = { "prettierd" },
                typescript = { "prettierd" },
                typescriptreact = { "prettierd" },
                lua = { "stylua" },
                proto = { "buf" },
                sh = { "shfmt" },
                yaml = { "prettierd" },
            },
            format_on_save = function(bufnr)
                -- Disable with a global or buffer-local variable
                if vim.g.disable_autoformat then
                    return
                end
                -- Disable autoformat for files in a certain path
                local bufname = vim.api.nvim_buf_get_name(bufnr)
                if bufname:match("/node_modules/") or bufname:match("/dist-packages/") then
                    return
                end
                return { lsp_fallback = true }
            end,
            config = function()
                vim.api.nvim_create_user_command("FormatDisable", function()
                    vim.g.disable_autoformat = true
                end, { desc = "Disable format on save" })
                vim.api.nvim_create_user_command("FormatEnable", function()
                    vim.g.disable_autoformat = false
                end, { desc = "Enable format on save" })
            end,
        },
    },
    {
        "mfussenegger/nvim-lint",
        config = function()
            require("lint").linters_by_ft = {
                bash = { "shellcheck" },
                go = { "golangcilint" },
                html = { "htmlhint" },
                javascript = { "eslint_d" },
                javascriptreact = { "eslint_d" },
                json = { "jsonlint" },
                proto = { "buf" },
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
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            { "theHamsta/nvim-dap-virtual-text", opts = {} },
            { "rcarriga/nvim-dap-ui",            dependencies = { "nvim-neotest/nvim-nio" } },
            {
                "mfussenegger/nvim-dap-python",
                config = function()
                    require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
                    require("dap-python").test_runner = "pytest"
                end,
            },
            {
                "leoluz/nvim-dap-go",
                config = function()
                    require("dap-go").setup()
                end
            },
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()

            vim.fn.sign_define("DapStopped", { text = ">>", texthl = "", linehl = "", numhl = "" })
            dap.defaults.fallback.exception_breakpoints = { "default" }
            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle breakpoint" })
            vim.keymap.set("n", "<leader>B", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "Debug: Set Conditional breakpoint" })
            vim.keymap.set("n", "<leader>dC", dap.clear_breakpoints, { desc = "Debug: Clear breakpoints" })
            vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Start/Continue" })
            vim.keymap.set("n", "<leader>dd", dap.run_last, { desc = "Debug: Run last" })
            vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
            vim.keymap.set("n", "<leader>dk", dap.close, { desc = "Debug: Kill" })
            vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Debug: Step Over" })
            vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Debug: Step Out" })
            vim.keymap.set("n", "<leader>d<space>", dap.repl.toggle, { desc = "Debug: Toggle REPL" })
            vim.keymap.set("n", "<leader>db", function() dap.list_breakpoints { true } end,
                { desc = "Debug: List breakpoints" })
            vim.keymap.set("n", "<leader>dr", dap.run_to_cursor, { desc = "Debug: Run to cursor" })
            vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI." })
            vim.keymap.set("n", "<leader>dw", function() dapui.float_element("watches") end, { desc = "Debug: Watches" })
            vim.keymap.set("n", "<leader>ds", function() dapui.float_element("scopes") end, { desc = "Debug: Scopes" })
            local debug_test = function()
                if vim.bo.filetype == "python" then
                    require("dap-python").test_method()
                elseif vim.bo.filetype == "go" then
                    require("dap-go").debug_test()
                else
                    print("No test runner for filetype: " .. vim.bo.filetype)
                end
            end
            vim.keymap.set("n", "<leader>dt", debug_test, { desc = "Debug: Nearest test" })
        end,

    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-go",
            "nvim-neotest/neotest-python",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local nt = require("neotest")
            nt.setup({
                adapters = {
                    require("neotest-go"),
                    require("neotest-python"),
                }
            })
            vim.keymap.set("n", "<leader>t", nt.run.run, { desc = "Test: Nearest" })
            vim.keymap.set("n", "<leader>T", nt.summary.toggle, { desc = "Test: Summary" })
            vim.keymap.set("n", "[t", nt.jump.prev, { desc = "Previous test" })
            vim.keymap.set("n", "]t", nt.jump.next, { desc = "Next test" })
        end
    },
}, {})
