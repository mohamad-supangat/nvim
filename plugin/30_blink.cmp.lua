local add, later = MiniDeps.add, MiniDeps.later


-- Snippets
later(function()
  add('rafamadriz/friendly-snippets')
  add('L3MON4D3/LuaSnip')

  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. '/after/snippets' } })
end)


-- blink.cmp
later(function()
  add({
    source = "saghen/blink.cmp",
    checkout = "v1.10.2",
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
    signature = { enabled = true },
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
      default = {
        -- "emoji",
        -- "lazydev",
        -- "avante",
        "supermaven",
        "snippets",
        "lsp",
        "path",
        "buffer",
        "codecompanion",
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
