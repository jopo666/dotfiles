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
-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    callback = function()
        if vim.bo.filetype ~= "proto" then
            vim.cmd([[ %s/\s\+$//e ]])
        end
    end,
})
-- Highlight yanked text
vim.cmd([[ au TextYankPost * silent! lua vim.highlight.on_yank() ]])
-- Restore cursor position
vim.cmd([[ autocmd BufReadPost *  if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]])
-- Sane formatoptions
vim.cmd([[ autocmd FileType * set formatoptions-=ro ]])
-- Filetype specific color columns
vim.cmd([[ autocmd FileType gitcommit setlocal colorcolumn=50,70 ]])
vim.cmd([[ autocmd FileType python setlocal colorcolumn=88 ]])
vim.cmd([[ autocmd FileType lua setlocal colorcolumn=100 ]])

--- KEYMAPS ---
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("i", "<c-h>", "<left>")
vim.keymap.set("i", "<c-j>", "<down>")
vim.keymap.set("i", "<c-k>", "<up>")
vim.keymap.set("i", "<c-l>", "<right>")
vim.keymap.set("c", "<c-p>", "<up>")
vim.keymap.set("c", "<c-n>", "<down>")
vim.keymap.set("n", "<tab>", ":bn<cr>", { desc = "Next buffer", silent = true })
vim.keymap.set("n", "<s-tab>", ":bp<cr>", { desc = "Previous buffer", silent = true })
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")
-- Disable annoying pageup/pagedown mappings.
vim.keymap.set({ "i", "n", "v" }, "<pageup>", "<nop>")
vim.keymap.set({ "i", "n", "v" }, "<pagedown>", "<nop>")
-- Don't jump to next search result
vim.keymap.set("n", "*", "m`:keepjumps normal! *``<cr>")
vim.keymap.set("n", "#", "m`:keepjumps normal! #``<cr>")
-- Move by visual lines
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- Don't yank when pasting in visual mode
vim.keymap.set("x", "p", [["_dp]])
vim.keymap.set("x", "P", [["_dP]])
-- Toggle quickfix
vim.keymap.set("n", "<leader>q", function()
    for _, win in pairs(vim.fn.getwininfo()) do
        if win.quickfix == 1 then
            return vim.cmd("cclose")
        end
    end
    vim.cmd("copen")
end, { desc = "Toggle quickfix" })
-- Clipboard mappings
vim.keymap.set({ "n", "x" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set({ "n", "x" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })
-- Diagnostic mappings
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show error" })
vim.keymap.set("n", "<leader>w", vim.diagnostic.setqflist, { desc = "Quickfix errors" })
-- Buffer mappings
vim.keymap.set("n", "<leader>x", "<cmd>bd<cr>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>o", function()
    local current = vim.api.nvim_get_current_buf()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if buf ~= current then
            vim.api.nvim_buf_delete(buf, { force = true })
        end
    end
end, { desc = "Close other buffers" })
-- Misc mappings
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "Clear search" })
vim.keymap.set("n", "<space><space>", "<c-^>", { desc = "Switch buffers" })
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<cr>", { desc = "Make file executable" })

--- PLUGINS ---
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath, })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
    { "tpope/vim-commentary" },                   -- comment/uncomment
    { "tpope/vim-repeat" },                       -- repeat plugin commands
    { "tpope/vim-rsi" },                          -- readline in insert mode
    { "tpope/vim-sleuth" },                       -- auto set shiftwidth and expandtab
    { "tpope/vim-unimpaired" },                   -- extra movements
    { "echasnovski/mini.ai",         opts = {} }, -- extra text objects
    { "echasnovski/mini.cursorword", opts = {} }, -- highlight word under cursor
    { "echasnovski/mini.jump",       opts = {} }, -- improved fFtT
    {
        "echasnovski/mini.splitjoin",
        opts = { mappings = { toggle = "<leader>j" } }
    },
    {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        opts = {}
    },
    {
        "folke/flash.nvim",
        opts = {},
        keys = {
            { "<c-s>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        },
    },
    {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        config = function()
            local copilot = require("copilot")
            local suggestion = require("copilot.suggestion")
            copilot.setup {
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    hide_during_completion = false,
                    debounce = 75,
                    keymap = {
                        accept = false,
                        next = "<M-]>",
                        prev = "<M-[>",
                    },
                },
                filetypes = {},
            }
            vim.keymap.set("i", "<c-space>", function()
                if not suggestion.is_visible() then
                    suggestion.next()
                else
                    suggestion.accept()
                end
            end, { desc = "Accept copilot suggestion" })
            vim.keymap.set("n", "<leader>tp", suggestion.toggle_auto_trigger, { desc = "Toggle copilot" })
        end,
    },
    {
        "shellRaining/hlchunk.nvim",
        opts = {
            indent = {
                enable = true,
                chars = { "┆" },
            }
        }
    },
    {
        "gbprod/substitute.nvim",
        config = function()
            require("substitute").setup({
                highlight_substituted_text = {
                    enabled = false
                }
            })
            vim.keymap.set("n", "s", require("substitute").operator, { noremap = true })
            vim.keymap.set("n", "ss", require("substitute").line, { noremap = true })
            vim.keymap.set("n", "S", require("substitute").eol, { noremap = true })
            vim.keymap.set("x", "s", require("substitute").visual, { noremap = true })
        end,
    },
    { "kylechui/nvim-surround", opts = {} },
    {
        "mbbill/undotree",
        keys = { { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle undotree" } }

    },
    {
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup {
                columns = {},
                constrain_cursor = "editable",
                keymaps = {
                    ["g?"] = "actions.show_help",
                    ["<CR>"] = "actions.select",
                    ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
                    ["<C-s>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
                    ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
                    ["-"] = "actions.parent",
                },
                use_default_keymaps = false,
                view_options = {
                    show_hidden = true,
                },
            }
            vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Browse files" })
        end
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
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add          = { text = "+" },
                change       = { text = "~" },
                delete       = { text = "x" },
                topdelete    = { text = "x" },
                changedelete = { text = "~" },
                untracked    = { text = "┆" },
            },
            signs_staged = {
                add          = { text = "+" },
                change       = { text = "~" },
                delete       = { text = "x" },
                topdelete    = { text = "x" },
                changedelete = { text = "~" },
                untracked    = { text = "┆" },
            },
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")
                vim.keymap.set("n", "]h", gitsigns.next_hunk, { buffer = bufnr, desc = "Next hunk" })
                vim.keymap.set("n", "[h", gitsigns.prev_hunk, { buffer = bufnr, desc = "Previous hunk" })
                vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
                vim.keymap.set("v", "<leader>hs",
                    function() gitsigns.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end,
                    { buffer = bufnr, desc = "Stage hunk" })
                vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
                vim.keymap.set("v", "<leader>hr",
                    function() gitsigns.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end,
                    { buffer = bufnr, desc = "Reset hunk" })
                vim.keymap.set("n", "<leader>hu", gitsigns.undo_stage_hunk, { buffer = bufnr, desc = "Undo stage hunk" })
                vim.keymap.set("n", "<leader>hb", function() gitsigns.blame_line { full = true } end,
                    { buffer = bufnr, desc = "Hunk blame" })
                vim.keymap.set("n", "<leader>hd", gitsigns.diffthis, { buffer = bufnr, desc = "Diff this" })
                vim.keymap.set("n", "<leader>td", gitsigns.toggle_deleted, { buffer = bufnr, desc = "Toggle deleted" })
            end,
        }
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<c-p>",     "<cmd>Telescope find_files theme=dropdown previewer=false<cr>",                desc = "Find files" },
            { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find theme=dropdown previewer=false<cr>", desc = "Fuzzy find buffer" },
            { "<leader>g", "<cmd>Telescope live_grep<cr>",                                                desc = "Live grep" },
            { "<leader>s", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",                            desc = "Find LSP symbols" },
            { "<leader>?", "<cmd>Telescope help_tags<cr>",                                                desc = "Find help tags" },
            { "<leader>k", "<cmd>Telescope keymaps<cr>",                                                  desc = "Find keymaps" },
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
            globalstatus = true,
            options = {
                icons_enabled = false,
                section_separators = "",
                component_separators = ""
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "diagnostics" },
                lualine_c = { { "buffers", symbols = { modified = "", alternate_file = "", directory = "" } } },
                lualine_x = { "diff", "branch" },
                lualine_y = {},
                lualine_z = { "location" },
            },
        }
    },
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
            "nvim-treesitter/nvim-treesitter-textobjects",
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
                    "proto",
                    "python",
                    "rust",
                    "toml",
                    "typescript",
                    "vimdoc",
                    "yaml",
                    "zig",
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
            require "treesitter-context".setup {
                max_lines = 4,
                multiline_threshold = 1,
                trim_scope = "outer",
            }
            vim.keymap.set("n", "<leader>tc", function()
                require("treesitter-context").toggle()
            end, { desc = "Toggle context" })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
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
                    return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt"
                        or require("cmp_dap").is_dap_buffer()
                end,
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
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
                    { name = "copilot",  index = 1 },
                    { name = "nvim_lsp", index = 1 },
                    { name = "luasnip",  index = 1 },
                    { name = "path",     index = 1 },
                    { name = "buffer",   index = 2 },
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
                    { name = "cmdline", index = 1 },
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
                "williamboman/mason-lspconfig.nvim",
                opts = {
                    automatic_installation = true,
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
                        "ruff",
                        "prettierd",
                        "shellcheck",
                        "shfmt",
                    }
                }
            }
        },
        config = function()
            require("mason-lspconfig").setup {}
            require("mason-lspconfig").setup_handlers {
                function(server_name)
                    require("lspconfig")[server_name].setup {}
                end,
            }
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
        config = function()
            local conform = require("conform")
            conform.setup {
                formatters_by_ft = {
                    bash = { "shfmt" },
                    go = { "goimports", "gofumpt" },
                    javascript = { "prettierd" },
                    javascriptreact = { "prettierd" },
                    json = { "prettierd" },
                    lua = { "stylua" },
                    markdown = { "prettierd" },
                    proto = { "buf_lint" },
                    python = { "ruff_organize_imports", "ruff_format" },
                    sh = { "shfmt" },
                    typescript = { "prettierd" },
                    typescriptreact = { "prettierd" },
                    yaml = { "prettierd" },
                },
                format_on_save = function(bufnr)
                    if vim.g.disable_autoformat then
                        return
                    end
                    local bufname = vim.api.nvim_buf_get_name(bufnr)
                    if bufname:match("/node_modules/") or bufname:match("/dist-packages/") then
                        return
                    end
                    return { lsp_fallback = true }
                end,
            }
            -- vim.api.nvim_create_user_command("FormatDisable", function()
            --     vim.g.disable_autoformat = true
            -- end, { desc = "Disable format on save" })
            -- vim.api.nvim_create_user_command("FormatEnable", function()
            --     vim.g.disable_autoformat = false
            -- end, { desc = "Enable format on save" })
        end,
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
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            { "theHamsta/nvim-dap-virtual-text", opts = { enabled = false } },
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
            vim.keymap.set("n", "<leader>dd", dap.run_last, { desc = "Debug: Run last" })
            vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Start/Continue" })
            vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
            vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Debug: Step Over" })
            vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Debug: Step Out" })
            vim.keymap.set("n", "<leader>dr", dap.run_to_cursor, { desc = "Debug: Run to cursor" })
            vim.keymap.set("n", "<leader>dk", dap.close, { desc = "Debug: Kill" })
            vim.keymap.set("n", "<leader>d<space>", dap.repl.toggle, { desc = "Debug: Toggle REPL" })
            vim.keymap.set("n", "<leader>db", function() dap.list_breakpoint(true) end,
                { desc = "Debug: List breakpoints" })
            vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI." })
            vim.keymap.set("n", "<leader>dw", function() dapui.float_element("watches") end, { desc = "Debug: Watches" })
            vim.keymap.set("n", "<leader>ds", function() dapui.float_element("scopes") end, { desc = "Debug: Scopes" })
            vim.keymap.set("n", "<leader>dv", "<cmd>DapVirtualTextToggle<cr>", { desc = "Debug: Toggle virtual text" })
            vim.keymap.set("n", "<leader>dt", function()
                if vim.bo.filetype == "python" then
                    require("dap-python").test_method()
                elseif vim.bo.filetype == "go" then
                    require("dap-go").debug_test()
                else
                    print("No test runner for filetype: " .. vim.bo.filetype)
                end
            end, { desc = "Debug: Nearest test" })
        end,

    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-neotest/neotest-go",
            "nvim-neotest/neotest-python",
        },
        config = function()
            local nt = require("neotest")
            nt.setup({
                adapters = {
                    require("neotest-go"),
                    require("neotest-python"),
                }
            })
            vim.keymap.set("n", "<leader>tt", nt.run.run, { desc = "Test: Nearest" })
            vim.keymap.set("n", "<leader>tf", function() nt.run.run(vim.fn.expand("%")) end, { desc = "Test: File" })
            vim.keymap.set("n", "<leader>ts", nt.summary.toggle, { desc = "Test: Summary" })
            vim.keymap.set("n", "[t", nt.jump.prev, { desc = "Previous test" })
            vim.keymap.set("n", "]t", nt.jump.next, { desc = "Next test" })
        end
    },
}, {})
