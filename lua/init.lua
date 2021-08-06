require('config.bufferline')
-- require('config.lsp')

require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
  },
  context_commentstring = {
    enable = true
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
  }
}

require'treesitter-context'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    throttle = true, -- Throttles plugin updates (may improve performance)
}


-- require('nvim-biscuits').setup({
--   default_config = {
--     -- max_length = 12,
--     -- min_distance = 5,
--     prefix_string = " 📎 "
--   },
--   language_config = {
--     html = {
--       prefix_string = " 🌐 "
--     },
--     javascript = {
--       prefix_string = " ✨ ",
--       max_length = 80
--     },
--     php = {
--       disabled = true
--     },
--     python = {
--       disabled = true
--     }
--   }
-- })
