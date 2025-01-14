return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            -- Virtual text
            { "theHamsta/nvim-dap-virtual-text", opts = { enabled = false } },
            -- Nice UI.
            {
                "rcarriga/nvim-dap-ui",
                opts = {
                    controls = { enabled = true, },
                    floating = { border = "none" },
                    layouts = { {
                        elements = {
                            { id = "repl",   size = 0.75 },
                            { id = "scopes", size = 0.25 },
                        },
                        position = "bottom",
                        size = 10
                    } }
                },
                dependencies = { "nvim-neotest/nvim-nio" }
            },
            -- Adapters for different languages.
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
            vim.fn.sign_define("DapStopped", { text = ">", texthl = "WarningMsg", linehl = "", numhl = "WarningMsg" })
            -- Setup adapters
            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = { command = "codelldb", args = { "--port", "${port}" }, },
            }
            dap.configurations.zig = {
                {
                    name = 'Launch',
                    type = 'codelldb',
                    request = 'launch',
                    program = '${workspaceFolder}/zig-out/bin/${workspaceFolderBasename}',
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                    args = {},
                },
            }
            -- Close previews with q
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "dap-float",
                callback = function()
                    vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>close!<cr>", { noremap = true, silent = true })
                end
            })
        end,
        keys = {
            { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Condition: ')) end, desc = "Conditional breakpoint" },
            { "<leader>db", function() require("dap").toggle_breakpoint() end,                         desc = "Toggle breakpoint" },
            { "<leader>dq", function() require("dap").list_breakpoints(true) end,                      desc = "List breakpoints" },
            { "<leader>dc", function() require("dap").continue() end,                                  desc = "Run/Continue" },
            { "<leader>dn", function() require("dap").step_over() end,                                 desc = "Step over" },
            { "<leader>di", function() require("dap").step_into() end,                                 desc = "Step into" },
            { "<leader>do", function() require("dap").step_out() end,                                  desc = "Step out" },
            { "<leader>dr", function() require("dap").run_to_cursor() end,                             desc = "Run to Cursor" },
            { "<leader>dL", function() require("dap").run_last() end,                                  desc = "Run last" },
            { "<leader>dd", function() require("dap").repl.toggle() end,                               desc = "Toggle REPL" },
            { "<leader>dk", function() require("dap").terminate() end,                                 desc = "Kill" },
            { "<leader>dv", function() require("nvim-dap-virtual-text").toggle() end,                  desc = "Toggle virtual text" },
            { "<leader>du", function() require("dapui").toggle({}) end,                                desc = "Toggle UI" },
            { '<leader>dl', function() require("dapui").float_element("console", {}) end,              desc = "Show console" },
            { '<leader>de', function() require('dap.ui.widgets').hover() end,                          desc = "Evaluate" },
            {
                '<leader>df',
                function()
                    local widgets = require('dap.ui.widgets')
                    widgets.centered_float(widgets.frames)
                end,
                desc = "Frames"
            },
            {
                '<leader>ds',
                function()
                    local widgets = require('dap.ui.widgets')
                    widgets.centered_float(widgets.scopes)
                end,
                desc = "Scopes"
            },
            {
                "<leader>dt",
                function()
                    if vim.bo.filetype == "python" then
                        require("dap-python").test_method({ config = { justMyCode = false } })
                    elseif vim.bo.filetype == "go" then
                        require("dap-go").debug_test()
                    elseif vim.bo.filetype == "zig" then
                        require("neotest").run.run({ strategy = "dap" })
                    else
                        print("No test runner for filetype: " .. vim.bo.filetype)
                    end
                end,
                desc = "Debug test"
            }
        },
    },
}
