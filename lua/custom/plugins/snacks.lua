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
    picker = { enabled = true },
  },
  keys = {
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
    -- search
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
      '<leader>si',
      function()
        Snacks.picker.icons()
      end,
      desc = '[S]earch [i]cons',
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
      desc = 'Undo History',
    },
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
        Snacks.picker.lsp_references()
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
        Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
        Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
        Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
        Snacks.toggle.diagnostics():map '<leader>ud'
        Snacks.toggle.line_number():map '<leader>ul'
        Snacks.toggle.indent():map '<leader>ug'
      end,
    })
  end,
}
