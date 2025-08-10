return {
  'akinsho/bufferline.nvim',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    local status_ok, bufferline = pcall(require, 'bufferline')
    if not status_ok then
      return
    end

    vim.opt.termguicolors = true
    bufferline.setup {
      highlights = {
        fill = { link = 'Normal' },
      },
    }
  end,
}
