local add, later = MiniDeps.add, MiniDeps.later

local config = require("config_reader").read_config()

if config.ai_supermaven then
  later(function()
    add("supermaven-inc/supermaven-nvim")

    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<C-y>",
        clear_suggestion = "<C-]>",
        accept_word = "<C-j>",
      },
      ignore_filetypes = { cpp = true }, -- or { "cpp", }
      -- color = {
      --   suggestion_color = "#ffffff",
      --   cterm = 244,
      -- },
      log_level = "info",
      disable_inline_completion = config.blink_cmp,
      disable_keymaps = 1,
      -- condition = function()
      --   return false
      -- end,
    })
  end)
end
