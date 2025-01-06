return {

    -- Split/tmux navigation
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
        },
    },

    -- Better netrw
    {
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup {
                columns = {},
                skip_confirm_for_simple_edits = false,
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

    -- Fuzzy searching
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        opts = {
            pickers = {
                find_files = {
                    theme = "dropdown",
                    previewer = false,
                },
                buffers = {
                    theme = "dropdown",
                    previewer = false,
                },
                colorscheme = {
                    enable_preview = true
                }
            },
        },
        keys = {
            { "<c-p>",      "<cmd>Telescope find_files<cr>",                    desc = "Find files" },
            { "<c-n>",      "<cmd>Telescope buffers<cr>",                       desc = "Find buffers" },
            { "<leader>g",  "<cmd>Telescope live_grep<cr>",                     desc = "Live grep" },
            { "<leader>fs", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Find LSP symbols" },
            { "<leader>fc", "<cmd>Telescope colorscheme<cr>",                   desc = "Find colorscheme" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>",                     desc = "Find help tags" },
            { "<leader>fk", "<cmd>Telescope keymaps<cr>",                       desc = "Find keymaps" },
            { "<leader>fn", "<cmd>Telescope find_files cwd=~/.config/nvim<cr>", desc = "Find nvim dotfiles" },
        }
    },

    -- Move between saved buffers
    {
        "leath-dub/snipe.nvim",
        keys = {
            { "<cr>", function() require("snipe").open_buffer_menu() end, desc = "Buffer menu" }
        },
        opts = {}
    },
}
