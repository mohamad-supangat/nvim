local add, later, now = MiniDeps.add, MiniDeps.later, MiniDeps.now
local now_if_args = Config.now_if_args


now(function()
  vim.lsp.enable({
    -- "vtsls",
    -- "vue_ls",
    'ts_ls',
    'lua_ls',
    -- 'kulala_ls',
    'phpantom',
    'intelephense',
    'emmet_language_server',
    'tailwindcss',
  })
end)

-- later(function()
--   add('stevearc/conform.nvim')
--
--   require('conform').setup({
--     default_format_opts = {
--       lsp_format = 'fallback',
--     },
--   })
-- end)

later(function()
  add('nvimtools/none-ls.nvim')

  local nuls = require("null-ls")

  nuls.setup({
    cache = false,
    debug = false,
    temp_dir = "/tmp",
    -- on_attach = require("lsp.handlers").on_attach,
    sources = {
      nuls.builtins.completion.tags,
      nuls.builtins.formatting.blade_formatter,
      -- nuls.builtins.completion.spell,
      -- nuls.builtins.completion.nvim_snippets,
      -- nuls.builtins.completion.luasnip,
      -- nuls.builtins.formatting.biome,
      nuls.builtins.formatting.phpcsfixer.with({
        condition = function(utils)
          return utils.root_has_file({ ".php_cs.dist", ".php_cs", "composer.json" })
        end
      }),
      nuls.builtins.formatting.prettier.with({
        extra_filetypes = { "toml", "css", "json5", "vue" },
        condition = function(utils)
          return utils.root_has_file({ ".prettierrc" })
        end,
      }),


      nuls.builtins.formatting.buf,
      nuls.builtins.diagnostics.buf,


      nuls.builtins.diagnostics.fish,
      -- nuls.builtins.diagnostics.editorconfig_checker,
      nuls.builtins.hover.dictionary,
    },

    -- on_attach = function(client, bufnr)
    -- Auto Format On Save
    -- if client.supports_method("textDocument/formatting") then
    --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    --     vim.api.nvim_create_autocmd("BufWritePre", {
    --         group = augroup,
    --         buffer = bufnr,
    --         callback = function()
    --             vim.lsp.buf.format({ bufnr = bufnr, async = true })
    --         end,
    --     })
    -- end
    -- end,
  })
end)
