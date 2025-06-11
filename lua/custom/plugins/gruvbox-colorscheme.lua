return {
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = true,
    init = function()
      -- Load the colorscheme here.
      vim.cmd.colorscheme 'gruvbox'
    end,
  },
}
