require('config.bufferline')
-- require('config.lsp')

require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust", "vue" },  -- list of language that will be disabled
  },
}


require('nvim-biscuits').setup({
  default_config = {
    -- max_length = 12,
    -- min_distance = 5,
    prefix_string = " 📎 "
  },
  language_config = {
    html = {
      prefix_string = " 🌐 "
    },
    javascript = {
      prefix_string = " ✨ ",
      max_length = 80
    },
    php = {
      disabled = true
    },
    python = {
      disabled = true
    }
  }
})
