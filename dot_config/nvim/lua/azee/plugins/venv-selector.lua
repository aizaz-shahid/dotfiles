-- return {}
return {
  'linux-cultist/venv-selector.nvim',
  cmd = 'VenvSelect',
  dependencies = {
    'neovim/nvim-lspconfig',
    'mfussenegger/nvim-dap',
    'nvim-telescope/telescope.nvim',
  },
  branch = 'regexp', -- This is the regexp branch, use this for the new version
  opts = {
    dap_enabled = true,
    settings = {
      options = {
        notify_user_on_venv_activation = true,
      },
    },
  },
  --  Call config for python files and load the cached venv automatically
  -- ft = 'python',
  config = function()
    require('venv-selector').setup()
  end,
  keys = {
    { '<leader>v', '<cmd>VenvSelect<cr>', { desc = 'Select Python Venv', ft = 'python' } },
  },
}
