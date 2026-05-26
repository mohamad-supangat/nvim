local add, later = MiniDeps.add, MiniDeps.later

later(function()
  add('obsidian-nvim/obsidian.nvim')
  require('obsidian').setup({
    legacy_commands = false,
    workspaces = {
      {
        name = "Reksa Karya",
        path = "~/Documents/Obsidian/Reksa/",
      },
      {
        name = "Aura Komputer",
        path = "~/Documents/Obsidian/AuraKomputer",
      },
    },
    notes_subdir = "notes",
    daily_notes = {
      folder = "notes/dailies",
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y",
      default_tags = { "daily-notes" },
      template = nil,
    },
    templates = {
      folder = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },
    frontmatter = {
      enabled = false,
    },
    checkbox = {
      enabled = true,
      create_new = true,
      order = { " ", "x", "~", "!", ">" },
    }
  })


  -- Obsidian keymaps
  vim.keymap.set("n", "<leader>no", ":Obsidian<CR>",
    { noremap = true, silent = true, desc = "Obsidian" })

  vim.keymap.set("n", "<Leader>nk", function()
    MiniPick.builtin.files({}, {
      source = {
        name = 'Obsidian Notes',
        cwd = vim.fn.expand('~/Documents/Obsidian/'),
      },
    })
  end, { noremap = true, silent = true, desc = "Obsidian notes picker" })
end)
