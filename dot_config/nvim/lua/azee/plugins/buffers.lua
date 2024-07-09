return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup {
        options = {
          separator_style = 'slope',
        },
      }
    end,
  },
  {
    'ton/vim-bufsurf',
    config = function()
      vim.keymap.set('n', '{', ':BufSurfBack<CR>', { silent = true, desc = 'Switch to previous buffer' })
      vim.keymap.set('n', '}', ':BufSurfForward<CR>', { silent = true, desc = 'Switch to next buffer' })
    end,
  },
}
