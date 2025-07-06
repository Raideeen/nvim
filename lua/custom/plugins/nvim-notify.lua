return {
  'rcarriga/nvim-notify',
  opts = {
    stages = 'fade_in_slide_out',
    on_open = nil,
    on_close = nil,
    render = 'default',
    timeout = 3500,
    max_width = 150,
    max_height = 25,
    background_colour = 'TabLine',
    minimum_width = 50,
    icons = {
      ERROR = '',
      WARN = '',
      INFO = '',
      DEBUG = '',
      TRACE = '',
    },
  },
  config = function()
    -- Enable notify vim API to use nvim-notify plugin
    vim.notify = require 'custom/plugins/nvim-notify'
  end,
}
