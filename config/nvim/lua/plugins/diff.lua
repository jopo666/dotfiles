return {
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
                vim.keymap.set("n", "]h", function() gitsigns.nav_hunk('next') end,
                    { buffer = bufnr, desc = "Next hunk" })
                vim.keymap.set("n", "[h", function() gitsigns.nav_hunk('prev') end,
                    { buffer = bufnr, desc = "Previous hunk" })
                vim.keymap.set("n", "]H", function() gitsigns.nav_hunk('last') end,
                    { buffer = bufnr, desc = "Last hunk" })
                vim.keymap.set("n", "[H", function() gitsigns.nav_hunk('first') end,
                    { buffer = bufnr, desc = "First hunk" })
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
                vim.keymap.set("n", "<leader>hD", gitsigns.toggle_deleted, { buffer = bufnr, desc = "Toggle deleted" })
            end,
        }
    },
}
