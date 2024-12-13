return {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "VeryLazy" },
    lazy = vim.fn.argc(-1) == 0,
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context",
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        require("nvim-treesitter.configs").setup({
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
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
                swap = {
                    enable = true,
                    swap_next = {
                        ["]a"] = "@parameter.inner",
                    },
                    swap_previous = {
                        ["[a"] = "@parameter.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]f"] = "@function.outer",
                        ["]c"] = "@class.outer",
                        ["]s"] = "@struct.outer",
                    },
                    goto_previous_start = {
                        ["[f"] = "@function.outer",
                        ["[c"] = "@class.outer",
                        ["[s"] = "@struct.outer",
                    },
                },
            },
        })
        require "treesitter-context".setup {
            max_lines = 4,
            multiline_threshold = 1,
            trim_scope = "outer",
        }
        require("treesitter-context").disable()
        vim.keymap.set("n", "<leader>c", function()
            require("treesitter-context").toggle()
        end, { desc = "Toggle context" })
    end,
}
