local config = require("config_reader").read_config()
local add = MiniDeps.add

if config.colorscheme == 'wal' then
  local function load_wal_colors()
    local wal_colors = dofile(vim.fn.expand("~/.cache/wal/colors-nvim.lua"))
    require('mini.hues').setup({
      background = wal_colors.background,
      foreground = wal_colors.foreground,
      -- n_hues = 8,
    -- saturation = 'low',
      plugins = {
        default = true
      }
    })
  end

  load_wal_colors()
  Config.new_autocmd("Signal", "SIGUSR1", load_wal_colors, 'Auto reload wal colorscheme')
elseif config.colorscheme == 'tokyonight' then
  add("https://github.com/folke/tokyonight.nvim")
  require('tokyonight').setup({
    style = "night",
    transparent = false
  })
  vim.cmd [[colorscheme tokyonight]]
elseif config.colorscheme == 'kanagawa' then
  add("https://github.com/rebelot/kanagawa.nvim")
  require('kanagawa').setup({
    style = "night",
    transparent = false
  })
  vim.cmd [[colorscheme kanagawa]]
else
  vim.cmd('colorscheme ' .. config.colorscheme)
end

-- Step one ===================================================================
-- now(function() vim.cmd('colorscheme miniwinter') end)

-- now(function() vim.cmd('colorscheme minispring') end)
-- now(function() vim.cmd('colorscheme minisummer') end)
-- now(function() vim.cmd('colorscheme miniautumn') end)
-- now(function() vim.cmd('colorscheme randomhue') end)
