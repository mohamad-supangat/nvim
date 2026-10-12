require('smart-splits').setup({
  -- buffers to leave alone, see Ignore Lists below
  ignored_buftypes = { 'nofile', 'quickfix', 'prompt' },
  ignored_filetypes = { 'NvimTree' },

  resize = {
    -- cells to resize by, multiplied by `v:count1`
    amount = 1,
    -- added to `eventignore` for the duration of a resize
    ignored_events = { 'BufEnter', 'WinEnter' },
  },

  move = {
    -- 'stop' | 'wrap' | 'split' | fun(ctx), see At Edge Behavior below
    at_edge = 'split',
    -- keep the cursor on the same screen row when moving horizontally
    same_row = false,
  },

  swap = {
    move_cursor = false,
  },

  mux = {
    backend = 'smart-splits-backend-tmux',
    warn_if_unusable = false,
  },

  log = {
    -- 'trace' | 'debug' | 'info' | 'warn' | 'error'
    level = 'info',
    -- `true` for the default path, a string for a custom one, `false` to disable
    file = true,
  },
})
-- resizing splits, these accept a count, so `10<A-h>` resizes by 10 * config.resize.amount
vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)
-- moving between splits
vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
-- swapping buffers between windows
vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right)
