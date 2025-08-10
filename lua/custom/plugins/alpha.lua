return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'
    -- local utils = require 'utils'
    _Gopts = {
      position = 'center',
      hl = 'Type',
      wrap = 'overflow',
    }

    local function get_all_files_in_dir(dir)
      local files = {}
      local scan = vim.fn.globpath(dir, '**/*.lua', true, true)
      for _, file in ipairs(scan) do
        table.insert(files, file)
      end
      return files
    end

    local function load_random_header()
      math.randomseed(os.time())
      local header_folder = vim.fn.stdpath 'config' .. '/lua/custom/plugins/header_img/'
      local files = get_all_files_in_dir(header_folder)

      if #files == 0 then
        return nil
      end

      local random_file = files[math.random(#files)]
      local relative_path = random_file:sub(#header_folder + 1)
      local module_name = 'custom.plugins.header_img.' .. relative_path:gsub('/', '.'):gsub('\\', '.'):gsub('%.lua$', '')

      package.loaded[module_name] = nil

      local ok, module = pcall(require, module_name)
      if ok and module.header then
        return module.header
      else
        return nil
      end
    end

    local function change_header()
      local new_header = load_random_header()
      if new_header then
        dashboard.config.layout[2] = new_header
        vim.cmd 'AlphaRedraw'
      else
        print 'No images inside header_img folder.'
      end
    end

    local header = load_random_header()
    if header then
      dashboard.config.layout[2] = header
    else
      print 'No images inside header_img folder.'
    end

    dashboard.section.buttons.val = {
      -- dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button('b', '  > Browse files', ':Oil<CR>'),
      dashboard.button('z', '  > Browse Directories', '<cmd>lua require("snacks").picker.zoxide()<CR>'),
      dashboard.button('f', '󰈞  > Find file', '<cmd>lua require("snacks").picker.files()<CR>'),
      dashboard.button('r', '  > Recent', '<cmd>lua require("snacks").picker.recent()<CR>'),
    }

    dashboard.config.layout = {
      { type = 'padding', val = 3 },
      header,
      { type = 'padding', val = 2 },
      {
        type = 'group',
        val = dashboard.section.buttons.val,
        opts = { spacing = 1 },
      },
    }

    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)
  end,
}
