return {

    -- More textobjects.
    { "echasnovski/mini.ai",    opts = {} },

    -- Better J.
    {
        "echasnovski/mini.splitjoin",
        opts = { mappings = { toggle = "<leader>j" } }
    },

    -- Add/remove/change surroundings
    { "kylechui/nvim-surround", opts = {} },

    -- Substitute with register
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

    -- Undo tree
    {
        "mbbill/undotree",
        config = function()
            vim.cmd [[ let g:undotree_DiffAutoOpen = 0 ]]
        end,
        keys = { { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle undotree" } }
    },
}
