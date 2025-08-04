return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      { "<leader>dn", ":DapNew", },
      { "<leader>du", function() require("dapui").toggle() end, },
      { "<leader>dr", function() require("dap").run_last() end, },
      { "<leader>do", function() require("dap").repl.open() end, },

      { "<f5>", function() require("dap").continue() end, },
      { "<f6>", function() require("dap").step_over() end, },
      { "<f7>", function() require("dap").step_into() end, },
      { "<f8>", function() require("dap").step_out() end, },
      { "<f9>", function() require("dap").toggle_breakpoint() end, },
    },
    config = function()
      local dap = require('dap')
      dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = '/Users/krig/src/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
      }
      dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
          command = "/Users/krig/src/codelldb/extension/adapter/codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"
          args = {"--port", "${port}"},
        }
      }
      dap.configurations.c = {
        {
          name = "Launch file",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          args = function()
            return vim.split(vim.fn.input('Args: ', nil, 'file'), '%s')
          end,
          cwd = '${workspaceFolder}',
          stopAtEntry = true,
        },
        {
          name = 'Attach to gdbserver :1234',
          type = 'cppdbg',
          request = 'launch',
          MIMode = 'gdb',
          miDebuggerServerAddress = 'localhost:1234',
          miDebuggerPath = '/opt/homebrew/bin/gdb',
          cwd = '${workspaceFolder}',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          args = function()
            return vim.split(vim.fn.input('Args: ', nil, 'file'), '%s')
          end,
        },
      }
      dap.configurations.cpp = dap.configurations.c
      dap.configurations.odin = dap.configurations.c
      dap.configurations.rust = dap.configurations.c
      dap.configurations.zig = dap.configurations.c
      require("dapui").setup()
    end,
  },
}
