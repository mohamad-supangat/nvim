local add, later = MiniDeps.add, MiniDeps.later
local customSnippetPath = vim.fn.stdpath("config") .. '/after/snippets';

local config = require("config_reader").read_config()
later(function()
  add('rafamadriz/friendly-snippets')
  add("chrisgrieser/nvim-scissors")

  require("scissors").setup({
    snippetDir = customSnippetPath,
  })


  -- Nvim scissors mappings
  vim.keymap.set("n", "<leader>sne", function()
    require("scissors").editSnippet()
  end, { noremap = true, silent = true, desc = "Edit snippet" })

  vim.keymap.set({ "n", "x" }, "<leader>sna", function()
    require("scissors").addNewSnippet()
  end, { noremap = true, silent = true, desc = "Add new snippet" })
end)

if config.snippets.mini then
  -- setup cmdline juga
  require('mini.cmdline').setup()

  require("mini.completion").setup({
    window = {
      info = { height = 30, width = 80, border = "double" },
      signature = { height = 30, width = 80, border = "double" },
    },
    lsp_completion = {
      auto_setup = true,
      -- snippet_insert = function()
      --   vim.notify("Snippet Insert")
      --   if vim.g.snippets == "luasnip" then
      --     require("luasnip").expand({})
      --   elseif vim.g.snippets == "mini" then
      --     require("mini.snippets").insert({ match = false })
      --   end
      --
      --   local suggestion = require("supermaven-nvim.completion_preview")
      --   if suggestion.has_suggestion() then
      --     suggestion.on_accept_suggestion()
      --   end
      -- end,
    },
  })

  local function check_last_char()
    local line = vim.api.nvim_get_current_line()
    local cursor_col = vim.api.nvim_win_get_cursor(0)[2]
    local last_char = string.sub(line, cursor_col, cursor_col)
    if last_char == "{" then
      vim.b.minicompletion_disable = true
    else
      vim.b.minicompletion_disable = false
    end
  end
  vim.api.nvim_create_augroup("InsertBraceGroup", { clear = true })
  vim.api.nvim_create_autocmd("TextChangedI", {
    group = "InsertBraceGroup",
    callback = check_last_char,
  })


  require("mini.icons").tweak_lsp_kind()

  local keycode = vim.keycode
      or function(x)
        return vim.api.nvim_replace_termcodes(x, true, true, true)
      end
  local keys = {
    ["cr"] = keycode("<CR>"),
    ["ctrl-y"] = keycode("<C-y>"),
    ["ctrl-y_cr"] = keycode("<C-y><CR>"),
    ["ctrl-n"] = keycode("<C-n>"),
  }

  _G.cr_action = function()
    if vim.fn.pumvisible() ~= 0 then
      local item_selected = vim.fn.complete_info()["selected"] ~= -1
      if item_selected then
        return keys["ctrl-y"] or keys["ctrl-y_cr"]
      else
        -- jika tidak ada item yang di pilih namun menampilkan pop up maka pilih item pertama
        return keys["ctrl-n"]
      end
    else
      return require("mini.pairs").cr()
    end
  end

  vim.keymap.set("i", "<CR>", "v:lua._G.cr_action()", { expr = true })
  vim.keymap.set("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
  vim.keymap.set("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
  vim.keymap.set("i", "<C-j>", [[pumvisible() ? "\<C-n>" : "\<C-j>"]], { expr = true })
  vim.keymap.set("i", "<C-k>", [[pumvisible() ? "\<C-p>" : "\<C-k>"]], { expr = true })
end
-- }}} end mini.completion

-- {{{ mini snippets
if config.snippets.mini then
  local gen_loader = require("mini.snippets").gen_loader

  require("mini.snippets").setup({
    snippets = {
      { prefix = "cdate", body = "$CURRENT_YEAR-$CURRENT_MONTH-$CURRENT_DATE" },
      { prefix = "today", body = "$CURRENT_YEAR-$CURRENT_MONTH-$CURRENT_DATE" },
      gen_loader.from_lang(),
    },
    mappings = {
      expand = "<C-A-Space>",
      jump_next = "<C-l>",
      jump_prev = "<C-h>",
      stop = "<C-c>",
    },

    expand = {
      prepare = function(raw_snippets)
        local _, cont = MiniSnippets.default_prepare({})
        cont.cursor = vim.api.nvim_win_get_cursor(0)
        return MiniSnippets.default_prepare(raw_snippets, { context = cont })
      end,
      match = function(snippets)
        return snippets
        -- return MiniSnippets.default_match(snippets, { pattern_fuzzy = "%w*" })
      end,
      -- select = function(snippets, insert) return insert(snippets[1]) end,
      insert = function(snippet, _)
        return MiniSnippets.default_insert(snippet, {
          empty_tabstop = "",
          empty_tabstop_final = "",
          -- empty_tabstop = "•",
          -- empty_tabstop_final = "∎",

          normalize = false,
          -- lookup = {
          --   TM_SELECTED_TEXT = table.concat(vim.fn.getreg("a", true, true), "\n"),
          -- },
        })
      end,
    },
  })

  vim.api.nvim_create_autocmd({ "LspAttach" }, {
    callback = function()
      require("mini.snippets").start_lsp_server({
        match = false,
      })
    end,
    desc = "Start snippets as LSP Server",
  })

  -- disbale underline in current cursor
  -- i not exited with this
  -- Daftar highlight group yang ingin dihapus
  local groups = {
    "MiniSnippetsCurrent",
    "MiniSnippetsVisited",
    "MiniSnippetsUnvisited",
    "MiniSnippetsCurrentReplace",
    "MiniSnippetsFinal",
  }

  -- Loop untuk clear semuanya
  for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, {})
  end
end

-- Snippets
if config.snippets.luasnip then
  later(function()
    add('L3MON4D3/LuaSnip')

    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load({ paths = { customSnippetPath } })


    require('luasnip').config.setup({})




    -- keymaps
    vim.keymap.set("i", "<C-K>", function()
      require('luasnip').expand()
    end, { noremap = true, silent = true, desc = "Expand snippet" })

    vim.keymap.set("i", "<C-A-Space>", function()
      require('luasnip').expand_or_jumpable()
    end, { noremap = true, silent = true, desc = "Expand or jump" })

    vim.keymap.set({ "i", "s" }, "<C-L>", function()
      require('luasnip').jump(1)
    end, { noremap = true, silent = true, desc = "Jump forward" })

    vim.keymap.set({ "i", "s" }, "<C-H>", function()
      require('luasnip').jump(-1)
    end, { noremap = true, silent = true, desc = "Jump backward" })

    vim.keymap.set({ "i", "s" }, "<C-E>", function()
      if require('luasnip').choice_active() then
        require('luasnip').change_choice(1)
      end
    end, { noremap = true, silent = true, desc = "Change choice" })
  end)
end
