local add = MiniDeps.add
local now_if_args = Config.now_if_args

now_if_args(function()
  add('romus204/tree-sitter-manager.nvim')
  add('windwp/nvim-ts-autotag')
  add("folke/ts-comments.nvim")
  add("nvim-treesitter/nvim-treesitter-context")

  require("tree-sitter-manager").setup({
    ensure_installed = {
      'lua',
      "markdown_inline",
      "vimdoc",
      "lua",
      "typescript",
      "vue",
      "pug",
      "python",
      "php",
      "phpdoc",
      "prisma",
      "markdown",
      "html",
      "blade",
      "vim",
      "json",
      "css",
      "dockerfile",
      "bash",
      "fish",
      "javascript",
      "scss",
      "http",
      "xml",
      "yaml",
    },
    highlight = true,
  })


  require("ts-comments").setup({
    lang = {
      blade = "{{-- %s --}}",
    },
  })

  require('treesitter-context').setup({
    enable = true,            -- enable this plugin (can be enabled/disabled later via commands)
    max_lines = 0,            -- how many lines the window should span. values <= 0 mean no limit.
    min_window_height = 0,    -- minimum editor window height to enable context. values <= 0 mean no limit.
    line_numbers = true,
    multiline_threshold = 20, -- maximum number of lines to show for a single context
    trim_scope = "outer",     -- which context lines to discard if `max_lines` is exceeded. choices: 'inner', 'outer'
    mode = "cursor",          -- line used to calculate context. choices: 'cursor', 'topline'
    separator = "_",
    zindex = 20,              -- the z-index of the context window
  });


  require("nvim-ts-autotag").setup({
    opts = {
      enable_close = true,
      enable_rename = true,
      enable_close_on_slash = false,
    },
    aliases = {
      ["blade"] = "html",
      ["html.handlebars"] = "html",
    },
  })
end)
