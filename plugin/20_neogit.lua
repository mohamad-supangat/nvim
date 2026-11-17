local neogit = require('neogit')

neogit.setup({
  graph_style = 'unicode',
})
vim.keymap.set('n', '<Leader>gi', function()
  local root = require('utils').currentFileRootPath()
  neogit.open({ cwd = root })
end)
