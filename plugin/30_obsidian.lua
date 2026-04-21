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
    -- notes_subdir = "notes",
    -- daily_notes = {
    --   folder = "notes/dailies",
    --   date_format = "%Y-%m-%d",
    --   alias_format = "%B %-d, %Y",
    --   default_tags = { "daily-notes" },
    --   template = nil,
    -- },
    -- templates = {
    --   folder = "templates",
    --   date_format = "%Y-%m-%d",
    --   time_format = "%H:%M",
    -- },
    completion = {
      blink = vim.g.completion == "blink",
    },
    frontmatter = {
      enabled = false,
    },
  })
end)
