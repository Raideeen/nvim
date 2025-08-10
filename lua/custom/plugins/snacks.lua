return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true }, -- Prevent LSPs to load bigfiles
    dashboard = { enabled = false }, -- same...
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = {
      enabled = true,
      layout = 'telescope', -- Use 'telescope'-style layout
      layouts = {
        telescope = {
          reverse = true, -- Reverse the order of the layout (optional feature)
          layout = {
            box = 'horizontal', -- Main container arranges children horizontally
            backdrop = false, -- No backdrop behind the picker
            width = 0.8, -- Picker takes 80% of the available width
            height = 0.5, -- Picker takes 50% of the available height
            border = 'none', -- No border for the outer container
            {
              box = 'vertical', -- Left section: stack children vertically
              { win = 'list', title = ' Results ', title_pos = 'center', border = 'single' }, -- Results list window
              { win = 'input', height = 1, border = 'single', title = '{title} {live} {flags}', title_pos = 'center' }, -- Input window for search/filter
            },
            {
              win = 'preview', -- Right section: preview window
              title = '{preview:Preview}', -- Dynamic title for preview
              width = 0.45, -- Preview takes 45% of the width
              border = 'single', -- Single border for preview window
              title_pos = 'center', -- Center the preview title
            },
          },
        },
      },
    },
  },
  keys = {
    {
      '<leader><leader>',
      function()
        Snacks.picker.buffers()
      end,
      desc = '[ ] Find existing buffers',
    },
    -- Top Pickers & Explorer
    {
      '<leader>a',
      function()
        Snacks.picker.smart()
      end,
      desc = 'Smart Find Files',
    },
    {
      '<leader>n',
      function()
        Snacks.picker.notifications()
      end,
      desc = 'Notification History',
    },
    -- Grep
    {
      '<leader>sw',
      function()
        Snacks.picker.grep_word()
      end,
      desc = 'Visual selection or word',
      mode = { 'n', 'x' },
    },
    {
      '<leader>sg',
      function()
        Snacks.picker.grep()
      end,
      desc = '[S]earch by [g]rep',
    },
    {
      '<leader>s/',
      function()
        Snacks.picker.grep { buffers = true }
      end,
      desc = '[S]earch [/] in Open Files',
    },
    {
      '<leader>s.',
      function()
        Snacks.picker.grep { buffers = false }
      end,
      desc = '[S]earch [.] in Current Folder',
    },
    -- search
    {
      '<leader>/',
      function()
        Snacks.picker.lines()
      end,
      desc = '[/] Fuzzily search in current buffer',
    },
    {
      '<leader>sh',
      function()
        Snacks.picker.help()
      end,
      desc = '[S]earch [h]elp',
    },
    {
      '<leader>sf',
      function()
        Snacks.picker.files { cwd = '.' }
      end,
      desc = '[S]earch [f]iles in current folder',
    },
    {
      '<leader>sr',
      function()
        Snacks.picker.recent()
      end,
      desc = '[S]earch [r]ecent files',
    },
    {
      '<leader>ss',
      function()
        Snacks.picker.commands()
      end,
      desc = '[S]earch [s]nacks commands',
    },
    {
      '<leader>sr',
      function()
        Snacks.picker.registers()
      end,
      desc = '[S]earch [r]egisters',
    },
    {
      '<leader>sb',
      function()
        Snacks.picker.lines()
      end,
      desc = '[S]earch [b]uffer lines',
    },
    {
      '<leader>sc',
      function()
        Snacks.picker.command_history()
      end,
      desc = '[S]earch [c]ommand history',
    },
    {
      '<leader>sC',
      function()
        Snacks.picker.commands()
      end,
      desc = '[S]earch NVIM [C]ommands',
    },
    {
      '<leader>sd',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = '[S]earch [d]iagnostics',
    },
    {
      '<leader>sD',
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = '[S]earch Buffer [D]iagnostics',
    },
    {
      '<leader>sI',
      function()
        Snacks.picker.icons()
      end,
      desc = '[S]earch [I]cons',
    },
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = '[S]earch [K]eymaps',
    },
    {
      '<leader>sm',
      function()
        Snacks.picker.marks()
      end,
      desc = '[S]earch [m]arks',
    },
    {
      '<leader>sM',
      function()
        Snacks.picker.man()
      end,
      desc = '[S]earch [M]an Pages',
    },
    {
      '<leader>sq',
      function()
        Snacks.picker.qflist()
      end,
      desc = '[S]earch [q]uickfix list',
    },
    {
      '<leader>su',
      function()
        Snacks.picker.undo()
      end,
      desc = '[S]earch [u]ndo history',
    },
    {
      '<leader>sn',
      function()
        Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = '[S]earch [N]eovim files',
    },
    {
      '<leader>st',
      function()
        Snacks.picker.todo_comments()
      end,
      desc = '[S]earch [t]odo comments',
    },
    -- Toggles
    {
      '<leader>uC',
      function()
        Snacks.picker.colorschemes()
      end,
      desc = 'Colorschemes',
    },
    -- LSP
    {
      'gd',
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = 'Goto Definition',
    },
    {
      'gD',
      function()
        Snacks.picker.lsp_declarations()
      end,
      desc = 'Goto Declaration',
    },
    {
      'gr',
      function()
        Snacks.picker.lp_references()
      end,
      nowait = true,
      desc = 'References',
    },
    {
      'gI',
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = 'Goto Implementation',
    },
    {
      '<leader>.',
      function()
        Snacks.scratch()
      end,
      desc = 'Toggle Scratch Buffer',
    },
    {
      '<leader>S',
      function()
        Snacks.scratch.select()
      end,
      desc = 'Select Scratch Buffer',
    },
    {
      '<leader>cR',
      function()
        Snacks.rename.rename_file()
      end,
      desc = 'Rename File',
    },
    {
      '<leader>gB',
      function()
        Snacks.gitbrowse()
      end,
      desc = 'Git Browse',
      mode = { 'n', 'v' },
    },
    {
      '<leader>gg',
      function()
        Snacks.lazygit()
      end,
      desc = 'Lazygit',
    },
    {
      '<leader>un',
      function()
        Snacks.notifier.hide()
      end,
      desc = 'Dismiss All Notifications',
    },
    {
      '<leader>tt',
      function()
        Snacks.terminal()
      end,
      desc = '[T]oggle [T]erminal',
    },
    -- {
    --   '<leader>N',
    --   desc = 'Neovim News',
    --   function()
    --     Snacks.win {
    --       file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
    --       width = 0.6,
    --       height = 0.6,
    --       wo = {
    --         spell = false,
    --         wrap = false,
    --         signcolumn = 'yes',
    --         statuscolumn = ' ',
    --         conceallevel = 3, }, } end, },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.indent():map '<leader>ug'
      end,
    })
  end,
}
