local config = require("config_reader").read_config()

if config.colorscheme == 'wal' then
  local wal_colors = dofile(vim.fn.expand("~/.cache/wal/colors-nvim.lua"))
  require('mini.hues').setup({
    background = wal_colors.background,
    foreground = wal_colors.foreground,
    -- n_hues = 8,
    -- saturation = 'low',
    plugins = {
      default = true,
    },
  })
else
  vim.cmd('colorscheme ' .. config.colorscheme)
end




-- Step one ===================================================================
-- now(function() vim.cmd('colorscheme miniwinter') end)

-- now(function() vim.cmd('colorscheme minispring') end)
-- now(function() vim.cmd('colorscheme minisummer') end)
-- now(function() vim.cmd('colorscheme miniautumn') end)
-- now(function() vim.cmd('colorscheme randomhue') end)
