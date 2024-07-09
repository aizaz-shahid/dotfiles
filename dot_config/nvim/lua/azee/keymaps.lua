-- This is a test commit.
-- This is another test commit.
-- This is the third commit.
-- Utility Keymaps
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights', noremap = true, silent = true })
vim.keymap.set({ 'n', 'x', 'o' }, '<Leader>c', 'gc', { remap = true, desc = 'Toggle comment' })

-- Indent with Tab in normal mode
vim.api.nvim_set_keymap('n', '<Tab>', '>>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', '<<', { noremap = true })

-- Indent with Tab in visual mode
vim.api.nvim_set_keymap('v', '<Tab>', '>gv', { noremap = true })
vim.api.nvim_set_keymap('v', '<S-Tab>', '<gv', { noremap = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>qd', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
-- Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Move highlighted text
vim.api.nvim_set_keymap('x', 'J', ":move '>+1<CR>gv=gv", { noremap = true })
vim.api.nvim_set_keymap('x', 'K', ":move '<-2<CR>gv=gv", { noremap = true })

-- Quickfix keymaps
vim.keymap.set('n', '<leader>qo', ':copen<CR>', { desc = 'Open quickfix list' })
vim.keymap.set('n', '<leader>qf', ':cfirst<CR>', { desc = 'Jump to first quickfix list item' })
vim.keymap.set('n', '<leader>qn', ':cnext<CR>', { desc = 'jump to next quickfix list item' })
vim.keymap.set('n', '<leader>qp', ':cprev<CR>', { desc = 'jump to prev quickfix list item' })
vim.keymap.set('n', '<leader>ql', ':clast<CR>', { desc = 'jump to last quickfix list item' })
vim.keymap.set('n', '<leader>qc', ':cclose<CR>', { desc = 'close quickfix list' })

-- Copy Paste Keymaps
vim.keymap.set('n', '<C-a>', 'ggVG', { desc = 'Select All' })
vim.keymap.set('v', 'x', '"+d', { desc = 'Cut' })
vim.keymap.set('n', 'X', '"+dd', { desc = 'Cut line' })
vim.keymap.set({ 'n', 'v' }, 'y', '"+y', { desc = 'Copy', noremap = true })
vim.keymap.set('n', '<leader>cp', ':let @+=expand("%:p")<CR>', { desc = 'Copy current file path to clipboard' })
vim.keymap.set({ 'n', 'v' }, 'p', '"+p', { desc = 'Paste', noremap = true })

-- Git Keymaps
vim.keymap.set('n', '<leader>gs', ':Neogit<CR>', { desc = 'Git Status', silent = true, noremap = true })
-- vim.keymap.set('n', '<leader>gc', ':Neogit commit<CR>', { silent = true, noremap = true })
-- vim.keymap.set('n', '<leader>gp', ':Neogit pull<CR>', { silent = true, noremap = true })
-- vim.keymap.set('n', '<leader>gP', ':Neogit push<CR>', { silent = true, noremap = true })
vim.keymap.set('n', '<leader>gb', ':Telescope git_branches<CR>', { desc = 'Git Branches', silent = true, noremap = true })
vim.keymap.set('n', '<leader>gtl', ':lua require("telescope").extensions.git_worktree.git_worktrees()<CR>', { desc = 'List Git Worktrees' })
vim.keymap.set('n', '<leader>gtc', ':lua require("telescope").extensions.git_worktree.create_git_worktree()<CR>', { desc = 'Create Git Worktree' })

-- Database Keymap
vim.keymap.set('n', '<leader>db', ':DBUIToggle<CR>', { desc = 'Toggle Databases' })

-- Scroll Keymaps
vim.keymap.set('n', 'L', '5zl', { desc = 'Scroll right' })
vim.keymap.set('n', 'H', '5zh', { desc = 'Scroll left' })
-- vim.keymap.set('n', '<C-k>', '<C-y>', { desc = 'Scroll up' })
-- vim.keymap.set('n', '<C-j>', '<C-e>', { desc = 'Scroll down' })

-- Jumplist Keymaps
vim.keymap.set('n', '<leader>sj', function()
  require('telescope.builtin').jumplist {}
end, { desc = 'Jumplist' })

-- Macros Keymaps
vim.keymap.set('n', 'Q', '@qj', { desc = 'Run macro' })
vim.keymap.set('x', 'Q', ':normal @q<CR>', { desc = 'Run macro' })

-- Debug Keymaps
vim.api.nvim_set_keymap('n', '<leader>tb', ':lua require("dap").toggle_breakpoint()<CR>', { silent = true, noremap = true, desc = 'Toggle Breakpoint' })
vim.api.nvim_set_keymap('n', '<leader>dm', ':lua require("dap-python").test_method()<CR>', { silent = true, noremap = true, desc = 'Debug Method' })
vim.api.nvim_set_keymap('n', '<leader>dC', ':lua require("dap-python").test_class()<CR>', { silent = true, noremap = true, desc = 'Debug Class' })
vim.api.nvim_set_keymap('v', '<leader>ds', '<ESC>:lua require("dap-python").debug_selection()<CR>', { silent = true, noremap = true, desc = 'Debug Selection' })

-- Undotree Keymaps
vim.keymap.set('n', '<leader>U', vim.cmd.UndotreeToggle, { desc = 'Toggle Undotree' })

-- Bufferline Keymaps
-- vim.keymap.set('n', '<C-[>', ':BufferLineCyclePrev<CR>', { silent = true, noremap = true, desc = 'Previous Buffer' })
vim.keymap.set('n', '<C-]>', ':BufferLineCycleNext<CR>', { silent = true, desc = 'Next Buffer' })
