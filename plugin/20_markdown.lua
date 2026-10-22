local obsidianPath = vim.fn.expand('~/Documents/Obsidian/')
vim.keymap.set(
  'n',
  '<leader>no',
  '<cmd>edit ' .. obsidianPath .. '<CR>:lcd %:p:h<CR>',
  { noremap = true, silent = true, desc = 'Obsidian notes picker' }
)

vim.keymap.set('n', '<Leader>nk', function()
  MiniPick.builtin.files({}, {
    source = {
      name = 'Notes',
      cwd = obsidianPath,
    },
  })
end, { noremap = true, silent = true, desc = 'Obsidian notes picker' })

require('touchup').setup({
  filetypes = { 'markdown' },
  bullets = { enabled = true, icons = { '✸', '✿', '✦', '✧' } },
  checkboxes = {
    enabled = true,
    -- Obsidian-style checkbox states. Standard `[ ]`/`[x]` are handled via
    -- treesitter; every other key is matched by a regex fallback against
    -- `- [<char>]` / `* [<char>]` / `+ [<char>]`.
    icons = {
      ['x'] = { text = '󰗠', hl = 'TouchupCheckboxChecked' },
      ['X'] = { text = '󰗠', hl = 'TouchupCheckboxChecked' },
      ['/'] = { text = '󱎖', hl = 'TouchupCheckboxPending' },
      ['>'] = { text = '', hl = 'TouchupCheckboxCancelled' },
      ['<'] = { text = '󰃖', hl = 'TouchupCheckboxCancelled' },
      ['-'] = { text = '󰍶', hl = 'TouchupCheckboxCancelled' },
      ['?'] = { text = '󰋗', hl = 'TouchupCheckboxPending' },
      ['!'] = { text = '󰀦', hl = 'TouchupCheckboxImportant' },
      ['*'] = { text = '󰓎', hl = 'TouchupCheckboxPending' },
      ['"'] = { text = '󰸥', hl = 'TouchupCheckboxCancelled' },
      ['l'] = { text = '󰆋', hl = 'TouchupCheckboxProgress' },
      ['b'] = { text = '󰃀', hl = 'TouchupCheckboxProgress' },
      ['i'] = { text = '󰰄', hl = 'TouchupCheckboxChecked' },
      ['S'] = { text = '', hl = 'TouchupCheckboxChecked' },
      ['I'] = { text = '󰛨', hl = 'TouchupCheckboxPending' },
      ['p'] = { text = '', hl = 'TouchupCheckboxChecked' },
      ['c'] = { text = '', hl = 'TouchupCheckboxUnchecked' },
      ['f'] = { text = '󱠇', hl = 'TouchupCheckboxUnchecked' },
      ['k'] = { text = '', hl = 'TouchupCheckboxPending' },
      ['w'] = { text = '', hl = 'TouchupCheckboxProgress' },
      ['u'] = { text = '󰔵', hl = 'TouchupCheckboxChecked' },
      ['d'] = { text = '󰔳', hl = 'TouchupCheckboxUnchecked' },
    },
  },
  code_blocks = { enabled = true },
  comment_blocks = { enabled = true },
  yap = { enabled = true },
  markers = { enabled = true },
  quotes = { enabled = true },
  enter = { enabled = true },
})
