return {
  {
    'nvim-neotest/neotest-python',
    lazy = true,
  },
  {
    'nvim-neotest/neotest',
    -- optional = true,
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-python',
    },
    keys = {
      {
        '<leader>tr',
        function()
          require('neotest').run.run()
        end,
        desc = 'Run Nearest Test',
      },
      {
        '<leader>td',
        function()
          require('neotest').run.run { strategy = 'dap' }
        end,
        desc = 'Debug Nearest Test',
      },
      {
        '<leader>tf',
        function()
          require('neotest').run.run(vim.fn.expand '%')
        end,
        desc = 'Run current File',
      },
      {
        '<leader>ta',
        function()
          local function trim_path_to_directory(directory_name)
            local current_file_path = vim.api.nvim_buf_get_name(0)
            local path_components = {}
            for component in string.gmatch(current_file_path, '[^/]+') do
              table.insert(path_components, component)
            end

            local trimmed_path = ''
            for i, component in ipairs(path_components) do
              trimmed_path = trimmed_path .. '/' .. component
              if component == directory_name then
                break
              end
            end

            return trimmed_path
          end

          local dir = vim.fn.input 'Enter parent directory: '
          require('neotest').run.run(trim_path_to_directory(dir))
          print(dir)
          -- require('neotest').run.run(vim.uv.cwd())
        end,
        desc = 'Run All Test Files',
      },
      {
        '<leader>ts',
        function()
          require('neotest').summary.toggle()
        end,
        desc = 'Toggle Tests Summary',
      },
      {
        '<leader>to',
        function()
          require('neotest').output.open { enter = true, auto_close = true }
        end,
        desc = 'Show Output',
      },
      {
        '<leader>tO',
        function()
          require('neotest').output_panel.toggle()
        end,
        desc = 'Toggle Output Panel',
      },
      {
        '<leader>tl',
        function()
          require('neotest').run.run_last()
        end,
        desc = 'Run Last Test',
      },
      {
        '<leader>tS',
        function()
          require('neotest').run.stop()
        end,
        desc = 'Stop',
      },
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-python' {
            dap = { justMyCode = false },
            args = { '--log-level', 'DEBUG', '-vv' },
            runner = 'pytest',
            -- python = '/Users/aizazshahid/.pyenv/versions/3.11.0/bin/python3.11',
          },
          -- require 'neotest-plenary',
        },
      }
      require('neodev').setup {
        ft = { 'lua', 'vim' },
        library = { plugins = { 'neotest' }, types = true },
      }
    end,
  },
}
