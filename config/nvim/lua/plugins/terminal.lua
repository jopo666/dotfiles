return {
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = function()
            require("toggleterm").setup({
                size = 20,
                direction = 'float',
                float_opts = {
                    border = 'single'
                },
            })
            vim.cmd [[
                command Z w | qa
                cabbrev wqa Z
            ]]
        end,
        keys = {
            { "<c-s>", "<cmd>ToggleTerm<cr>", mode = { "n", "t" } },
        }
    }
}
