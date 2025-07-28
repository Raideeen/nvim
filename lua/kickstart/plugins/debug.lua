-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'vadimcn/codelldb',
  },
  keys = {
    -- F-key mappings (keep these for quick access)
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
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: Toggle UI',
    },

    -- Leader mappings (these will show in which-key)
    {
      '<leader>dc',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Continue (F5)',
    },
    {
      '<leader>di',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into (F1)',
    },
    {
      '<leader>do',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over (F2)',
    },
    {
      '<leader>dO',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out (F3)',
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
      '<leader>du',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: Toggle UI (F7)',
    },
    {
      '<leader>dr',
      function()
        require('dap').repl.open()
      end,
      desc = 'Debug: Open REPL',
    },
    {
      '<leader>dl',
      function()
        require('dap').run_last()
      end,
      desc = 'Debug: Run Last',
    },
    {
      '<leader>dt',
      function()
        require('dap').terminate()
      end,
      desc = 'Debug: Terminate',
    },
    {
      '<leader>dh',
      function()
        require('dap.ui.widgets').hover()
      end,
      desc = 'Debug: Hover Variables',
    },
    {
      '<leader>dp',
      function()
        require('dap.ui.widgets').preview()
      end,
      desc = 'Debug: Preview',
    },
    {
      '<leader>df',
      function()
        local widgets = require 'dap.ui.widgets'
        widgets.centered_float(widgets.frames)
      end,
      desc = 'Debug: Frames',
    },
    {
      '<leader>ds',
      function()
        local widgets = require 'dap.ui.widgets'
        widgets.centered_float(widgets.scopes)
      end,
      desc = 'Debug: Scopes',
    },
  },

  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
        'codelldb',
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

    -- Change breakpoint icons
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    local breakpoint_icons = vim.g.have_nerd_font
        and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
      or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Configure adapters
    local codelldb_path = vim.fn.stdpath 'data' .. '/mason/packages/codelldb/extension/adapter/codelldb'

    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = codelldb_path,
        args = { '--port', '${port}' },
      },
    }

    -- Helper function to find executable
    local function find_executable()
      -- Look for common executable patterns
      local patterns = {
        vim.fn.getcwd() .. '/target/debug/*', -- Rust debug builds
        vim.fn.getcwd() .. '/target/release/*', -- Rust release builds
        vim.fn.getcwd() .. '/build/*', -- CMake builds
        vim.fn.getcwd() .. '/bin/*', -- Common bin directory
        vim.fn.getcwd() .. '/*', -- Current directory
      }

      for _, pattern in ipairs(patterns) do
        local files = vim.fn.glob(pattern, false, true)
        for _, file in ipairs(files) do
          -- Check if file is executable and not a directory
          if vim.fn.executable(file) == 1 and vim.fn.isdirectory(file) == 0 then
            -- Skip common non-executable files
            local filename = vim.fn.fnamemodify(file, ':t')
            if not filename:match '%.' and filename ~= 'Cargo.toml' and filename ~= 'CMakeLists.txt' then
              return file
            end
          end
        end
      end

      -- Fallback to manual input
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end

    dap.configurations.cpp = {
      {
        name = 'Launch file (auto-detect)',
        type = 'codelldb',
        request = 'launch',
        program = find_executable,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
      },
      {
        name = 'Launch file (manual)',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
      },
      {
        name = 'Launch with arguments',
        type = 'codelldb',
        request = 'launch',
        program = find_executable,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = function()
          local args_string = vim.fn.input 'Arguments: '
          return vim.split(args_string, ' ')
        end,
      },
    }

    dap.configurations.c = dap.configurations.cpp

    -- Rust-specific configuration
    dap.configurations.rust = {
      {
        name = 'Launch Rust (debug)',
        type = 'codelldb',
        request = 'launch',
        program = function()
          -- Try to find the debug executable
          local debug_path = vim.fn.getcwd() .. '/target/debug/'
          local files = vim.fn.readdir(debug_path)
          for _, file in ipairs(files or {}) do
            local full_path = debug_path .. file
            if vim.fn.executable(full_path) == 1 and not file:match '%.' then
              return full_path
            end
          end
          return vim.fn.input('Path to executable: ', debug_path, 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
      },
      {
        name = 'Launch Rust (release)',
        type = 'codelldb',
        request = 'launch',
        program = function()
          local release_path = vim.fn.getcwd() .. '/target/release/'
          local files = vim.fn.readdir(release_path)
          for _, file in ipairs(files or {}) do
            local full_path = release_path .. file
            if vim.fn.executable(full_path) == 1 and not file:match '%.' then
              return full_path
            end
          end
          return vim.fn.input('Path to executable: ', release_path, 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
      },
    }

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }
    -- Which-key group setup (optional - helps organize the menu)
    local function setup_which_key_debug()
      local ok, wk = pcall(require, 'which-key')
      if not ok then
        return
      end

      -- Just register the group - individual mappings are handled by the keys table above
      wk.add {
        { '<leader>d', group = 'Debug' },
      }
    end

    -- Call this function at the end of your config function
    setup_which_key_debug()
  end,
}
