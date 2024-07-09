return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-live-grep-args.nvim',
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = '^1.0.0',
    },
    -- 'nvim-telescope/telescope-frecency.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    {
      'danielfalk/smart-open.nvim',
      branch = '0.2.x',
      dependencies = {
        'kkharji/sqlite.lua',
        'nvim-tree/nvim-web-devicons',
        -- Optional.  If installed, native fzy will be used when match_algorithm is fzy
        { 'nvim-telescope/telescope-fzy-native.nvim' },
      },
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  keys = {
    {
      '<leader>ff',
      function()
        require('telescope').extensions.live_grep_args.live_grep_args {
          mappings = {
            i = {
              ['<C-t>'] = function()
                local prompt_bufnr = vim.api.nvim_get_current_buf()
                local prompt_text = vim.api.nvim_buf_get_lines(prompt_bufnr, 0, 1, false)[1]
                vim.api.nvim_buf_set_text(prompt_bufnr, 0, #prompt_text, 0, #prompt_text, { ' -t' })
                vim.api.nvim_win_set_cursor(0, { 1, #prompt_text + 3 })
              end,
              -- Add the filter out / exclude glob pattern
              ['<C-x>'] = function()
                local prompt_bufnr = vim.api.nvim_get_current_buf()
                local prompt_text = vim.api.nvim_buf_get_lines(prompt_bufnr, 0, 1, false)[1]
                vim.api.nvim_buf_set_text(prompt_bufnr, 0, #prompt_text, 0, #prompt_text, { ' -g!**' })
                vim.api.nvim_win_set_cursor(0, { 1, #prompt_text + 5 })
              end,
              -- Add the filter / include only glob pattern
              ['<C-i>'] = function()
                local prompt_bufnr = vim.api.nvim_get_current_buf()
                local prompt_text = vim.api.nvim_buf_get_lines(prompt_bufnr, 0, 1, false)[1]

                vim.api.nvim_buf_set_text(prompt_bufnr, 0, #prompt_text, 0, #prompt_text, { ' -g**/*/**' })
                vim.api.nvim_win_set_cursor(0, { 1, #prompt_text + 6 })
              end,
              ['<C-h>'] = function()
                local prompt_bufnr = vim.api.nvim_get_current_buf()
                local prompt_text = vim.api.nvim_buf_get_lines(prompt_bufnr, 0, 1, false)[1]
                if not string.find(prompt_text, '--hidden') then
                  vim.api.nvim_buf_set_text(prompt_bufnr, 0, #prompt_text, 0, #prompt_text, { ' --hidden' })
                end
              end,
            },
          },
        }
      end,
      desc = 'Live Grep with Arguments',
    },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      defaults = {
        layout_strategy = 'vertical',
        layout_config = { height = 0.99, width = 0.99 },
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
      },
      -- pickers = {}
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        live_grep_args = {
          auto_quoting = false,
        },
        -- frecency = {
        --   auto_validate = false,
        --   matcher = 'fuzzy',
        --   path_display = { 'filename_first' },
        --   workspaces = {
        --     ['sas'] = '/Users/aizazshahid/Flexciton/dev/platform/schedule_analyser_service/src',
        --     ['platform'] = '/Users/aizazshahid/Flexciton/dev/platform/platform/src',
        --     ['config'] = '/Users/aizazshahid/Flexciton/dev/platform/config',
        --     ['helm'] = '/Users/aizazshahid/Flexciton/dev/platform/helm',
        --     ['platform_tests'] = '/Users/aizazshahid/Flexciton/dev/platform/platform/test',
        --     ['sas_tests'] = '/Users/aizazshahid/Flexciton/dev/platform/schedule_analyser_service/test',
        --   },
        -- },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    -- pcall(require('telescope').load_extension, 'frecency')
    pcall(require('telescope').load_extension, 'git_worktree')
    pcall(require('telescope').load_extension, 'live_grep_args')
    pcall(require('telescope').load_extension, 'smart_open')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find Help' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Find Keymaps' })
    vim.keymap.set('n', '<leader><leader>', function()
      require('telescope').extensions.smart_open.smart_open {
        cwd_only = false,
        hidden = true,
        filename_first = true,
        show_scores = false,
        match_algorithm = 'fzy',
        disable_devicons = false,
        open_buffer_indicators = { previous = '●', others = '⊙' },
      }
    end, { noremap = true, silent = true, desc = 'Find Files' })

    -- vim.keymap.set('n', '<leader>ff', function()
    --   builtin.find_files {
    --     hidden = true,
    --   }
    -- end, { desc = 'Find Files' })
    -- vim.keymap.set('n', '<leader>ff', '<Cmd>Telescope frecency<CR>', { desc = 'Find Files' })
    -- vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = 'Find Select Telescope' })
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Find Current Word' })
    -- vim.keymap.set('n', '<leader>ff', builtin.live_grep, { desc = 'Find by Grep' })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Find Diagnostics' })
    vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Find Resume' })
    vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = 'Find Recent Files ("." for repeat)' })
    -- vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>f/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    -- vim.keymap.set('n', '<leader>f/', function()
    --   builtin.live_grep {
    --     grep_open_files = true,
    --     prompt_title = 'Live Grep in Open Files',
    --   }
    -- end, { desc = 'Find in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>fn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = 'Find Neovim files' })
  end,
}
