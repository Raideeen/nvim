vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = { '*.c', '*.cpp' },
  callback = function()
    vim.cmd 'silent! edit'
  end,
})
