local add, later = MiniDeps.add, MiniDeps.later

local config = require("config_reader").read_config()

if config.ai.supermaven then
  later(function()
    add("supermaven-inc/supermaven-nvim")

    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<C-y>",
        clear_suggestion = "<C-backspace>",
        accept_word = "<leader>y",
      },
      -- ignore_filetypes = { cpp = true }, -- or { "cpp", }
      -- color = {
      --   suggestion_color = "#ffffff",
      --   cterm = 244,
      -- },
      log_level = "info",
      disable_inline_completion = config.completion.blink,
      disable_keymaps = config.completion.blink,
      -- condition = function()
      --   return false
      -- end,
    })
  end)
end
