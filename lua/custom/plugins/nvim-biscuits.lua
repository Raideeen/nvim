return {
  {
    'code-biscuits/nvim-biscuits',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      default_config = {
        max_length = 80,
        min_distance = 5,
        prefix_string = '📎 ',
      },
    },
    lazy = false,
  },
}
