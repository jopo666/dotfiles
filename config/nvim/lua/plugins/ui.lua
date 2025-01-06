return {
    -- Show keymaps
    {
        "echasnovski/mini.clue",
        opts = {
            window = { delay = 200 },
            triggers = {
                { mode = 'n', keys = '<Leader>' },
                { mode = 'x', keys = '<Leader>' },
            }
        },
    },

    -- Automatic tabwidth.
    { "tpope/vim-sleuth" },

    -- Zen mode
    {
        "folke/zen-mode.nvim",
        opts = {
            window = {
                width = 120, -- width of the Zen window
                options = {
                    cursorline = false,
                },
            },
            plugins = {
                gitsigns = { enabled = true },
                tmux = { enabled = true },
            },
        },
        keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Toggle zen" } }
    },

    -- Statusline
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
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "mode", "filename", "diagnostics" },
                lualine_x = { "branch", "location" },
                lualine_y = {},
                lualine_z = {},
            },
        }
    },

    -- Colorscheme
    {
        "sainnhe/gruvbox-material",
        config = function()
            vim.g.gruvbox_material_background = "hard"
            vim.g.gruvbox_material_better_performance = true
            vim.g.gruvbox_material_disable_italic_comment = false
            vim.cmd [[ colorscheme gruvbox-material ]]
        end
    },

    -- Markdown preview
    {
        "ellisonleao/glow.nvim",
        ft = "markdown",
        opts = {},
        keys = { { "<leader>M", "<cmd>Glow<cr>", desc = "Preview markdown" } }
    },

    -- Show register contents
    {
        "tversteeg/registers.nvim",
        cmd = "Registers",
        config = {
            show = "\"0123456789abcdefghijklmnopqrstuvwxyz",
            show_empty = false,
        },
        keys = {
            { "\"",    mode = { "n", "v" } },
            { "<C-R>", mode = "i" }
        },
        name = "registers",
    }
}
