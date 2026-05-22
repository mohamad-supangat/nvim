-- ┌─────────────────────────┐
-- │ Plugins outside of MINI │
-- └─────────────────────────┘
--

local add, later, now = MiniDeps.add, MiniDeps.later, MiniDeps.now
local now_if_args = Config.now_if_args
local config = require("config_reader").read_config()


now_if_args(function()
  add('nvim-lua/plenary.nvim')
end)

now_if_args(function()
  add('mason-org/mason.nvim')
  require('mason').setup()
end)


if config.plugins.symbol_outline then
  now_if_args(function()
    add('hedyhli/outline.nvim')
    require('outline').setup()

    -- Outline
    vim.keymap.set("n", "<F7>", "<cmd>Outline<CR>",
      { noremap = true, silent = true, desc = "Toggle Outline" })
  end)
end


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

if config.plugins.render_markdown then
  later(function()
    add('MeanderingProgrammer/render-markdown.nvim')
    require('render-markdown').setup({
      completions = { lsp = { enabled = true } },
      heading = { position = 'inline' },
      checkbox = {
        unchecked = { icon = '✘ ' },
        checked = { icon = '✔ ' },
        custom = { todo = { rendered = '◯ ' } },
      },
    })
  end)
end
