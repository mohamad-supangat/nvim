local add = MiniDeps.add
local now_if_args = Config.now_if_args

now_if_args(function()
  add('neovim-treesitter/treesitter-parser-registry')

  add({
    source = 'neovim-treesitter/nvim-treesitter',
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
    build = ':TSUpdate',
  })

  add('windwp/nvim-ts-autotag')
  add("nvim-treesitter/nvim-treesitter-context")
  add("JoosepAlviste/nvim-ts-context-commentstring")


  local languages = {
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

  }
  local isnt_installed = function(lang)
    return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0
  end
  local to_install = vim.tbl_filter(isnt_installed, languages)
  if #to_install > 0 then require('nvim-treesitter').install(to_install) end

  -- Enable tree-sitter after opening a file for a target language
  local filetypes = {}
  for _, lang in ipairs(languages) do
    for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
      table.insert(filetypes, ft)
    end
  end
  local ts_start = function(ev)
    vim.treesitter.start(ev.buf)
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
  Config.new_autocmd('FileType', filetypes, ts_start, 'Start tree-sitter')

  require('ts_context_commentstring').setup({
    enable_autocmd = false,
  })


  -- require("ts-comments").setup({
  --   lang = {
  --     blade = "{{-- %s --}}",
  --   },
  -- })

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
