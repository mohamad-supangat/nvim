if true or package.loaded['codecompanion'] then
  require('codecompanion').setup({
    extensions = {
      history = {
        enabled = true,
      },
    },
    interactions = {
      chat = {
        adapter = {
          name = 'openrouter',
          model = 'openrouter/free',
        },
        slash_commands = {
          opts = {
            acp = { trigger = '<C-Space>' },
          },
        },
      },
      inline = {
        adapter = {
          name = 'openrouter',
          model = 'openrouter/free',
        },
      },
    },
    opts = {
      language = 'Indonesia',
    },
    display = {
      chat = {
        start_in_insert_mode = false,
        show_references = true,
        separator = '─',
        window = {
          layout = 'float',
          height = 0.9,
          width = 0.9,
          opts = {
            breakindent = true,
            cursorcolumn = false,
            cursorline = false,
            foldcolumn = '0',
            linebreak = true,
            list = true,
            number = false,
            spell = false,
            wrap = true,
          },
        },
      },
    },
  })

  -- keymaps
  vim.keymap.set({ 'n' }, '<A-b>', '<cmd>CodeCompanionChat Toggle<CR>', { desc = 'Toggle CodeCompanion Chat' })
  vim.keymap.set({ 'x' }, '<A-b>', '<cmd>CodeCompanionChat<CR>', { desc = 'Send Selection to CodeCompanion Chat' })
  vim.keymap.set({ 'x' }, '<A-i>', '<cmd>CodeCompanion<CR>', { desc = 'Code Compantion inline prompt' })
end
