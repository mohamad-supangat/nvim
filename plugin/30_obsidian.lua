local add, later = MiniDeps.add, MiniDeps.later

later(function()
  add('obsidian-nvim/obsidian.nvim')
  require('obsidian').setup({
    legacy_commands = false,
    workspaces = {
      {
        name = "Reksa Karya",
        path = vim.env.HOME .. "/Documents/Obsidian/Reksa",
      },
      {
        name = "Aura Komputer",
        path = vim.env.HOME .. "/Documents/Obsidian/AuraKomputer",
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
    completion = {
      blink = vim.g.completion == "blink",
    },
    frontmatter = {
      enabled = false,
    },
    note_id_func = function(title)
      local suffix = ""
      if title ~= nil then
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. "-" .. suffix
    end,

    -- open_app_foreground = true,
  })
end)
