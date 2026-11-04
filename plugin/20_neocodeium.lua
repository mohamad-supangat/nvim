local neocodeium = require('neocodeium')
neocodeium.setup()
vim.keymap.set('i', '<C-y>', neocodeium.accept)
vim.keymap.set('n', '<C-y>', neocodeium.accept)

