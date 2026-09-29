-- debug.lua
--
-- Debugging with nvim-dap, set up for Python (debugpy) and Rust (codelldb).
-- Mason installs both adapters; mason-nvim-dap provides their launch configurations.
-- Other languages can be added with more `ensure_installed` entries and handlers.

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>db',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>dB',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Conditional Breakpoint',
    },
    {
      '<leader>dq',
      function()
        require('dap').terminate()
      end,
      desc = 'Debug: Stop',
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: See last session result.',
    },
    {
      '<leader>du',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: Toggle UI',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local mason_dap = require 'mason-nvim-dap'

    mason_dap.setup {
      automatic_installation = false,
      ensure_installed = { 'python', 'codelldb' },
      handlers = {
        -- Only the adapters listed above are set up; anything else Mason has is ignored.
        function() end,

        python = function(config)
          -- Run the program with the project's interpreter (active virtualenv or python3 on PATH),
          -- not the Python that Mason installed debugpy into.
          for _, c in ipairs(config.configurations or {}) do
            c.pythonPath = function()
              local venv = os.getenv 'VIRTUAL_ENV'
              return venv and (venv .. '/bin/python') or vim.fn.exepath 'python3'
            end
          end
          mason_dap.default_setup(config)
        end,

        codelldb = function(config)
          -- codelldb can also debug C/C++/Swift/Zig; this config only enables Rust.
          config.filetypes = { 'rust' }
          for _, c in ipairs(config.configurations or {}) do
            c.program = function()
              -- Build first (`cargo build`), then pick the binary from target/debug.
              return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
            end
          end
          mason_dap.default_setup(config)
        end,
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
  end,
}
