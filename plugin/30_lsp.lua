local add, later, now = MiniDeps.add, MiniDeps.later, MiniDeps.now
local now_if_args = Config.now_if_args
local config = require("config_reader").read_config()


now(function()
  local capabilities = require("lsp.capabilities")
  vim.lsp.config("*", {
    capabilities = capabilities,
  })

  vim.lsp.enable({
    "vtsls",
    "vue_ls",
    'ts_ls',
    'lua_ls',
    'kulala_ls',
    'phpantom_lsp',
    'intelephense',
    'emmet_language_server',
    'tailwindcss',
    'marksman',
    'pyright',
    'ty'
  })
end)


if config.format.conform then
  later(function()
    add('stevearc/conform.nvim')

    local util = require("conform.util")
    require('conform').setup({
      formatters_by_ft = {
        ["*"] = { "trim_whitespace", "trim_newlines" },
        -- lua = { "stylua" },
        python = { "blue", "ruff_fix", "ruff_format" },
        php = { "php_cs_fixer", "lsp" },
        blade = { "blade-formatter" },
        javascript = { "prettier" },
        markdown = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        json5 = { "prettier" },
        vue = { "prettier" },
        pug = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        sass = { "prettier" },
        bash = { "shfmt" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
        nginx = { "nginxfmt" },
        http = { "kulala" },
      },

      formatters = {
        kulala = {
          command = "kulala-fmt",
          args = { "format", "$FILENAME" },
          stdin = false,
        },
        php_cs_fixer = {
          command = "php-cs-fixer",
          env = {
            PHP_CS_FIXER_IGNORE_ENV = "1",
          },
          args = { "fix", "$FILENAME" },
          stdin = false,
          cwd = util.root_file({ ".rootdir", "composer.json" }),
        },
      },
    })

    vim.api.nvim_create_user_command("Format", function()
      vim.lsp.buf.format({ async = false, timeout_ms = 1000, })
      require("conform").format({ lsp_fallback = false, async = false, })
    end, {
      desc = "Format using lsp then conform",
    })

    vim.keymap.set("n", "<Leader>fm", "<Cmd>Format<CR>",
      { noremap = true, silent = true, desc = "Format" })

    vim.keymap.set("x", "<Leader>fm", "<Cmd>Format<CR>",
      { noremap = true, silent = true, desc = "Format selection" })
  end)
end

if config.format.none_ls then
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


    vim.keymap.set("n", "<Leader>fm", "<Cmd>lua vim.lsp.buf.format()<CR>",
      { noremap = true, silent = true, desc = "Format" })

    vim.keymap.set("x", "<Leader>fm", "<Cmd>lua vim.lsp.buf.format()<CR>",
      { noremap = true, silent = true, desc = "Format selection" })
  end)
end
