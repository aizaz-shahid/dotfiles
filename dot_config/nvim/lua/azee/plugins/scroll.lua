return {
  'karb94/neoscroll.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    scroll = require 'neoscroll'
    scroll.setup {
      mappings = { -- Keys to be mapped to their corresponding default scrolling animation
        '<C-b>',
        '<C-f>',
        '<C-y>',
        '<C-e>',
      },
      hide_cursor = true, -- Hide cursor while scrolling
      stop_eof = true, -- Stop at <EOF> when scrolling downwards
      respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
      cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
      easing = 'linear', -- Default easing function
      pre_hook = nil, -- Function to run before the scrolling animation starts
      post_hook = nil, -- Function to run after the scrolling animation ends
      performance_mode = false, -- Disable "Performance Mode" on all buffers.
    }
    neoscroll = require 'neoscroll'
    local keymap = {
      ['<C-b>'] = function()
        neoscroll.ctrl_b { duration = 450 }
      end,
      ['<C-f>'] = function()
        neoscroll.ctrl_f { duration = 450 }
      end,
      ['<C-u>'] = function()
        neoscroll.scroll(-0.1, { move_cursor = false, duration = 100 })
      end,
      ['<C-d>'] = function()
        neoscroll.scroll(0.1, { move_cursor = false, duration = 100 })
      end,
    }
    local modes = { 'n', 'v', 'x' }
    for key, func in pairs(keymap) do
      vim.keymap.set(modes, key, func)
    end
  end,
}
