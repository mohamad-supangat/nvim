-- ┌─────────────────────────┐
-- │ Plugins outside of MINI │
-- └─────────────────────────┘
--

local add, later, now = MiniDeps.add, MiniDeps.later, MiniDeps.now
local now_if_args = Config.now_if_args

now_if_args(function()
  add('nvim-lua/plenary.nvim')
end)

now_if_args(function()
  add('mason-org/mason.nvim')
  require('mason').setup()
end)


now_if_args(function()
  add('hedyhli/outline.nvim')
  require('outline').setup()
end)



-- Floating terminla
now_if_args(function()
  add("ingur/floatty.nvim")
  local term = require("floatty").setup({})
  vim.keymap.set('n', '<A-i>', function() term.toggle() end)
  vim.keymap.set('t', '<A-i>', function() term.toggle() end)

  function _G.lazygit()
    local lazygit = require("floatty").setup({
      cmd = "lazygit -p " .. require("utils").currentFileRootPath(),
      window = {
        width = 1,
        height = 1,
      }
    })
    lazygit.toggle()
  end

  -- local lazygit = require("floatty").setup({
  --   cmd = "lazygit -p " .. require("utils").currentFileRootPath(),
  -- })
  vim.keymap.set('n', '<Leader>gi', ":lua lazygit()<CR>")
  -- vim.keymap.set('t', '<Leader>gi', ":lua lazygit()<CR>")
end)







later(function()
  add("MagicDuck/grug-far.nvim")
  vim.g.maplocalleader = ","

  require("grug-far").setup({
    transient = true,
    prefills = {
      search = "",
      flags = "--multiline",
    },
    -- engine = 'ripgrep' is default, but 'astgrep' can be specified
  })
end)

now(function()
  add("mrjones2014/smart-splits.nvim")
  require('smart-splits').setup({})
end)
