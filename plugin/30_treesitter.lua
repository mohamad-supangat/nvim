local add = MiniDeps.add
local now_if_args = Config.now_if_args

now_if_args(function()
  add('romus204/tree-sitter-manager.nvim')
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

  add('windwp/nvim-ts-autotag')


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
