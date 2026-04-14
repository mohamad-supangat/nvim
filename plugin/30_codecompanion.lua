local add, later = MiniDeps.add, MiniDeps.later

later(function()
  add("olimorris/codecompanion.nvim")
  add("ravitemer/codecompanion-history.nvim")

  require(
    'codecompanion'
  ).setup({
    extensions = {
      history = {
        enabled = true, -- defaults to true
        opts = {
          dir_to_save = vim.fn.stdpath("data") .. "/codecompanion_chats.json",
        }
      }
    },
    interactions = {
      chat = {
        adapter = {
          name = 'gemini',
          model = 'gemini-3-flash-preview',
        },
        opts = {
          completion_provider = 'blink',
        },
        keymaps = {
        },
      },
      inline = {
        adapter = {
          name = 'gemini',
          model = 'gemini-3-flash-preview',
        },
        keymaps = {
          accept_change = {
            modes = { n = "ga" },
            description = "Accept the suggested change",
          },
          reject_change = {
            modes = { n = "gr" },
            description = "Reject the suggested change",
          },
        },
      },
    },
    opts = {
      language = "Indonesia",
    },
    display = {
      chat = {
        start_in_insert_mode = false,
        show_references = true,
        separator = "─",
        window = {
          layout = "float",
          height = 0.9,
          width = 0.9,
          opts = {
            breakindent = true,
            cursorcolumn = false,
            cursorline = false,
            foldcolumn = "0",
            linebreak = true,
            list = true,
            number = false,
            -- signcolumn = "yes",
            spell = false,
            wrap = true,
          },
        },
      },
    },
  })
end)
