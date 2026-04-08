-- ┌─────────────────────────┐
-- │ Plugins outside of MINI │
-- └─────────────────────────┘
--

local add, later = MiniDeps.add, MiniDeps.later
local now_if_args = Config.now_if_args

now_if_args(function()
  add('nvim-lua/plenary.nvim')
end)

now_if_args(function()
  add({
    source = 'nvim-treesitter/nvim-treesitter',
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
    checkout = '90cd6580e720caedacb91fdd587b747a6e77d61f',
  })
  add({
    source = 'nvim-treesitter/nvim-treesitter-textobjects',
    checkout = '93d60a475f0b08a8eceb99255863977d3a25f310',
  })

  local languages = {
    'lua',
    'vimdoc',
    'markdown',
    'blade',
    'php',
    'css',
    'json',
    'vue',
    'pug',
    'typescript',
    'javascript',
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
end)

now_if_args(function()
  add('neovim/nvim-lspconfig')
  vim.lsp.config("intelephense", {
    root_markers = { ".rootdir", "composer.json", ".git" },
    filetypes = { "php", "blade" },
  })


  vim.lsp.config['phpantom'] = {
    cmd = { 'phpantom_lsp' },
    filetypes = { 'php', 'blade' },
    root_markers = { '.rootdir', 'composer.json' },
  }
  vim.lsp.enable({
    -- "vtsls",
    -- "vue_ls",
    'ts_ls',
    'lua_ls',
    -- 'kulala_ls',
    'phpantom',
    'intelephense',
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


-- Snippets ===================================================================
later(function()
  add('rafamadriz/friendly-snippets')
  add('L3MON4D3/LuaSnip')

  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. '/after/snippets' } })
end)

now_if_args(function()
  add('mason-org/mason.nvim')
  require('mason').setup()
end)


-- Floating terminla
now_if_args(function()
  add("ingur/floatty.nvim")
  local term = require("floatty").setup({})
  vim.keymap.set('n', '<A-i>', function() term.toggle() end)
  vim.keymap.set('t', '<A-i>', function() term.toggle() end)

  function _G.lazygit()
    local lazygit = require("floatty").setup({
      cmd = "lazygit -p " .. require("utils").currentFileRootPath(),
      window = {
        width = 1,
        height = 1,
      }
    })
    lazygit.toggle()
  end

  -- local lazygit = require("floatty").setup({
  --   cmd = "lazygit -p " .. require("utils").currentFileRootPath(),
  -- })
  vim.keymap.set('n', '<Leader>gi', ":lua lazygit()<CR>")
  vim.keymap.set('t', '<Leader>gi', ":lua lazygit()<CR>")
end)

later(function()
  add("olimorris/codecompanion.nvim")
  add("ravitemer/codecompanion-history.nvim")

  require(
    'codecompanion'
  ).setup({
    extensions = {
      history = {
        enabled = true, -- defaults to true
        opts = {
          dir_to_save = vim.fn.stdpath("data") .. "/codecompanion_chats.json",
        }
      }
    },
    interactions = {
      chat = {
        adapter = {
          name = 'gemini',
          model = 'gemini-3-flash-preview',
        },
        opts = {
          completion_provider = (vim.g.completion == "blink") and "blink" or "default",
        },
        keymaps = {
        },
      },
      inline = {
        adapter = {
          name = 'gemini',
          model = 'gemini-3-flash-preview',
        },
        keymaps = {
          accept_change = {
            modes = { n = "ga" },
            description = "Accept the suggested change",
          },
          reject_change = {
            modes = { n = "gr" },
            description = "Reject the suggested change",
          },
        },
      },
    },
    opts = {
      language = "Indonesia",
    },
    display = {
      chat = {
        start_in_insert_mode = false,
        show_references = true,
        separator = "─",
        window = {
          layout = "float",
          height = 0.9,
          width = 0.9,
          opts = {
            breakindent = true,
            cursorcolumn = false,
            cursorline = false,
            foldcolumn = "0",
            linebreak = true,
            list = true,
            number = false,
            -- signcolumn = "yes",
            spell = false,
            wrap = true,
          },
        },
      },
    },
  })
end)

-- blink.cmp
later(function()
  add({
    source = "saghen/blink.cmp",
    checkout = "v1",
  })
  add({
    source = "saghen/blink.compat",
    checkout = "v2.5.0",
  })
  add("supermaven-inc/supermaven-nvim")

  require('blink.compat').setup({
    enable_events = true,
  })


  require('blink.cmp').setup({
    enabled = function()
      return vim.b.completion ~= false
      -- return not vim.tbl_contains(require("variables").exclude, vim.bo.filetype)
      --     and vim.bo.buftype ~= "prompt"
      --     and vim.b.completion ~= false
    end,
    -- signature = { enabled = true },
    fuzzy = {
      sorts = {
        "score",
      },
      implementation = "lua",
      -- implementation = "rust",
      --
      -- prebuilt_binaries = {
      --     force_version = "v1.10.2",
      -- },
    },
    -- snippets = { preset = "luasnip" },
    sources = {
      default = {
        -- "emoji",
        -- "lazydev",
        -- "avante",
        "supermaven",
        "snippets",
        "lsp",
        "path",
        "buffer",
        -- "codecompanion",
      },
      providers = {
        supermaven = {
          name = "supermaven",
          module = "blink.compat.source",
          async = true,
          score_offset = 1000,
          transform_items = function(_, items)
            local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
            local kind_idx = #CompletionItemKind + 1
            CompletionItemKind[kind_idx] = "Supermaven"
            for _, item in ipairs(items) do
              item.kind = kind_idx
            end
            return items
          end,
        },
      },
    },

    keymap = {
      preset = "none",
      -- ["<A-y>"] = {
      --   function(cmp)
      --     cmp.show({ providers = { "minuet" } })
      --   end,
      -- },
      ["<CR>"] = { "accept", "fallback" },
      -- ["<C-space>"] = {
      --   function(cmp)
      --     cmp.show({ providers = { "snippets" } })
      --   end,
      -- },
      ["<C-space>"] = { "show", "hide" },
      ["<C-S-k>"] = { "show_documentation", "hide_documentation", "fallback" },
      ["<C-e>"] = { "hide", "fallback" },

      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = {
        "select_prev",
        function()
          require("luasnip").jump(-1)
        end,
        "fallback",
      },
      ["<Tab>"] = {
        "select_next",
        function()
          require("luasnip").jump(1)
        end,
        "fallback",
      },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },

      -- ["<C-l>"] = { "accept", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },
    completion = {
      keyword = { range = "full" },
      accept = { auto_brackets = { enabled = false } },
      list = { selection = { preselect = true, auto_insert = false } },
      menu = {
        -- auto_show = true,
        auto_show = function(ctx)
          return true
          -- return ctx.mode ~= 'cmdline' and
          -- not vim.tbl_contains({ '/', '?' }, vim.fn.getcmdtype()) and
          -- return not vim.tbl_contains(require("variables").exclude, vim.bo.filetype)
        end,
        draw = {
          gap = 2,
          padding = { 1, 1 }, -- padding only on right side
          components = {},
          -- kind_icon = {
          --   text = function(ctx)
          --     return " " .. ctx.kind_icon .. ctx.icon_gap .. " "
          --   end,
          -- },
          columns = { { "label", "label_description", gap = 1 }, { "kind", gap = 1 } },
          -- treesitter = { 'lsp' }
        },
      },
      documentation = {
        auto_show = true,
        -- auto_show_delay_ms = 200,
        window = {},
      },
      trigger = {
        prefetch_on_insert = false,
        show_on_trigger_character = false,
        show_on_insert_on_trigger_character = false,
        show_on_accept_on_trigger_character = false,
      },
      ghost_text = { enabled = false },
    },
    -- signature = { window = { border = 'single' } },
    appearance = {
      use_nvim_cmp_as_default = true,
      -- nerd_font_variant = 'mono'
    },
  })


  require("supermaven-nvim").setup({
    keymaps = {
      accept_suggestion = "<C-y>",
      clear_suggestion = "<C-]>",
      accept_word = "<C-j>",
    },
    ignore_filetypes = { cpp = true }, -- or { "cpp", }
    -- color = {
    --   suggestion_color = "#ffffff",
    --   cterm = 244,
    -- },
    log_level = "info",
    disable_inline_completion = 1,
    disable_keymaps = 1,
    condition = function()
      return false
    end,
  })
end)


later(function()
  add("MagicDuck/grug-far.nvim")
  vim.g.maplocalleader = ","

  require("grug-far").setup({
    transient = true,
    prefills = {
      search = "",
      flags = "--multiline",
    },
    -- engine = 'ripgrep' is default, but 'astgrep' can be specified
  })
end)
