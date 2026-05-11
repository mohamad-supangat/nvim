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

  local term1 = require("floatty").setup({
    window = {
      width = 0.4,
      h_align = "left",
      v_align = "bottom",
    }
  })
  vim.keymap.set('n', '<f1>', function() term1.toggle() end)
  vim.keymap.set('t', '<f1>', function() term1.toggle() end)


  local term2 = require("floatty").setup({
    window = {
      width = 0.4,
      h_align = "right",
      v_align = "bottom",
    }
  })
  vim.keymap.set('n', '<f2>', function() term2.toggle() end)
  vim.keymap.set('t', '<f2>', function() term2.toggle() end)


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

  function _G.lazydocker()
    local lazygit = require("floatty").setup({
      cmd = "lazydocker",
      window = {
        width = 1,
        height = 1,
      }
    })
    lazygit.toggle()
  end

  vim.keymap.set('n', '<Leader>gi', ":lua lazygit()<CR>")
  vim.keymap.set('n', '<Leader>do', ":lua lazydocker()<CR>")
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
--
-- later(function()
--   add('MeanderingProgrammer/render-markdown.nvim')
--   require('render-markdown').setup({
--     completions = { lsp = { enabled = true } },
--     heading = { position = 'inline' },
--     checkbox = {
--       unchecked = { icon = '✘ ' },
--       checked = { icon = '✔ ' },
--       custom = { todo = { rendered = '◯ ' } },
--     },
--   })
-- end)
