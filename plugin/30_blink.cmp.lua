local add, later = MiniDeps.add, MiniDeps.later

local ai_completion = 'supermaven'
local config = require("config_reader").read_config()

-- Snippets
later(function()
  add('rafamadriz/friendly-snippets')
  add('L3MON4D3/LuaSnip')
  add("chrisgrieser/nvim-scissors")

  local customSnippetPath = vim.fn.stdpath("config") .. '/after/snippets';
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load({ paths = { customSnippetPath } })


  require('luasnip').config.setup({})

  require("scissors").setup({
    snippetDir = customSnippetPath,
  })
end)


-- blink.cmp
later(function()
  add({
    source = "saghen/blink.cmp",
    checkout = "v1.10.2",
  })

  local blink_sources = {
    "snippets",
    "lsp",
    "path",
    "buffer",
  }

  if config.plugins.codecompanion then
        table.insert(blink_sources, "codecompanion")
  end

  add({
    source = "saghen/blink.compat",
    checkout = "v2.5.0",
  })

  if ai_completion == 'supermaven' then
    add("supermaven-inc/supermaven-nvim")


    table.insert(blink_sources, "supermaven")

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
  end

  if ai_completion == 'windsurf' then
    add("Exafunction/codeium.nvim")

    require("codeium").setup({
    })

    table.insert(blink_sources, "codeium")
  end

  if ai_completion == 'neocideium' then
    add("monkoose/neocodeium")


    local neocodeium = require("neocodeium")
    -- neocodeium.setup({
    --   manual = true,
    -- })
    vim.api.nvim_create_autocmd('User', {
      pattern = 'BlinkCmpMenuOpen',
      callback = function()
        neocodeium.clear()
      end,
    })

    neocodeium.setup({
      filter = function()
        return not require('blink.cmp').is_visible()
      end,
    })
  end

  require('blink.compat').setup({
    enable_events = true,
  })


  require('blink.cmp').setup({
    fuzzy = {
      sorts = {
        "score",
      },
      -- implementation = "lua",
      implementation = "rust",
      --
      prebuilt_binaries = {
        force_version = "v1.10.2",
      },
    },
    snippets = { preset = "luasnip" },
    sources = {
      default = blink_sources,
      providers = {
        codeium = { name = 'Codeium', module = 'codeium.blink', async = true },
        supermaven = {
          name = "supermaven",
          module = "blink.compat.source",
          async = true,
          score_offset = 1000,
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
        border = "none",
        auto_show = true,
        draw = {
          gap = 2,
          padding = { 2, 2 }, -- padding only on right side
          columns = {
            { "kind_icon",   gap = 1 },
            { "label",       "label_description", gap = 1 },
            { "source_name", gap = 1 },
          },
          components = {
            source_name = {
              highlight = "BlinkCmpKind",
            },
          },
          treesitter = { 'lsp' }
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = "none",

        },
      },
      trigger = {
        prefetch_on_insert = false,
        show_on_trigger_character = false,
        show_on_insert_on_trigger_character = false,
        show_on_accept_on_trigger_character = false,
      },
      ghost_text = { enabled = false },
    },
    signature = { enabled = true, window = { border = 'none' } },
    appearance = {
      -- use_nvim_cmp_as_default = true,
      -- nerd_font_variant = 'mono'
    },
  })
end)
