-- ┌────────────────────┐
-- │ MINI configuration │
-- └────────────────────┘
--
local now, later = MiniDeps.now, MiniDeps.later
local now_if_args = Config.now_if_args

-- Step one ===================================================================
-- now(function() vim.cmd('colorscheme miniwinter') end)

-- now(function() vim.cmd('colorscheme minispring') end)
-- now(function() vim.cmd('colorscheme minisummer') end)
now(function() vim.cmd('colorscheme miniautumn') end)
-- now(function() vim.cmd('colorscheme randomhue') end)

now(function()
  require('mini.basics').setup({
    options = { basic = false },
    autocommands = {
      basic = true,
      relnum_in_visual_mode = true,
    },
    mappings = {
      basic = true,
      extra_ui = true,
      win_borders = "single",
      windows = true,
      move_with_alt = true,
    },
  })
end)

-- Icon provider. Usually no need to use manually. It is used by plugins like
-- 'mini.pick', 'mini.files', 'mini.statusline', and others.
now(function()
  -- Set up to not prefer extension-based icon for some extensions
  local ext3_blocklist = { scm = true, txt = true, yml = true }
  local ext4_blocklist = { json = true, yaml = true }
  require('mini.icons').setup({
    use_file_extension = function(ext, _)
      return not (ext3_blocklist[ext:sub(-3)] or ext4_blocklist[ext:sub(-4)])
    end,
  })

  -- Mock 'nvim-tree/nvim-web-devicons' for plugins without 'mini.icons' support.
  -- Not needed for 'mini.nvim' or MiniMax, but might be useful for others.
  later(MiniIcons.mock_nvim_web_devicons)

  -- Add LSP kind icons. Useful for 'mini.completion'.
  later(MiniIcons.tweak_lsp_kind)
end)

now(function() require('mini.notify').setup() end)
now(function() require('mini.sessions').setup() end)
now(function()
  local starter = require("mini.starter")

  starter.setup({
    evaluate_single = true,
    items = {
      {
        name = "Config: init.lua",
        action = "e ~/.config/nvim/init.lua",
        section = "Nvim",
      },
      {
        name = "Snippets: package.json",
        action = "e ~/projects/snippets/package.json",
        section = "Nvim",
      },
      {
        name = "Obsidian Vault",
        action = "e ~/Documents/Obsidian/",
        section = "Nvim",
      },
      starter.sections.sessions(5, true),
      starter.sections.builtin_actions(),
      starter.sections.recent_files(10, false),
      -- starter.sections.recent_files(10, true),
    },
    content_hooks = {
      starter.gen_hook.adding_bullet(),
      starter.gen_hook.aligning("center", "center"),
      starter.gen_hook.indexing("all", { "Builtin actions" }),
      starter.gen_hook.padding(10, 0),
    },
  })
end)

now(function()
  local function get_macro_status()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
      return ""
    end
    return "󰑊 Recording @" .. recording_register
  end


  require('mini.statusline').setup({
    content = {
      active = function()
        local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
        local git           = MiniStatusline.section_git({ trunc_width = 75 })
        local diag          = MiniStatusline.section_diagnostics({ trunc_width = 75 })
        local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
        local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
        local location      = MiniStatusline.section_location({ trunc_width = 75 })
        local macro         = get_macro_status()

        return MiniStatusline.combine_groups({
          { hl = mode_hl,                     strings = { mode } },
          { hl = 'MiniStatuslineDevinfo',     strings = { git, diag } },
          { hl = 'MiniStatuslineModeReplace', strings = { macro } },
          '%<',
          { hl = 'MiniStatuslineFilename', strings = { filename } },
          '%=',
          { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
          { hl = mode_hl,                  strings = { location } },
        })
      end
    }
  })
end)

-- Tabline. Sets `:h 'tabline'` to show all listed buffers in a line at the top.
-- Buffers are ordered as they were created. Navigate with `[b` and `]b`.
now(function() require('mini.tabline').setup() end)


if false then
  now_if_args(function()
    local process_items_opts = { kind_priority = { Text = -1, Snippet = 99 } }
    local process_items = function(items, base)
      return MiniCompletion.default_process_items(items, base, process_items_opts)
    end
    require('mini.completion').setup({
      lsp_completion = {
        source_func = 'omnifunc',
        auto_setup = false,
        process_items = process_items,
      },
    })

    local on_attach = function(ev)
      vim.bo[ev.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
    end
    Config.new_autocmd('LspAttach', nil, on_attach, "Set 'omnifunc'")
    vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() })
  end)
end

now_if_args(function()
  require('mini.files').setup({
    use_as_default_explorer = true,
    content = {
      filter = function(fs_entry)
        return true
      end,
      -- prefix = function() end, -- disable icon in mini.files,
    },
    width_focus = 30,
    width_nofocus = 20,
    width_preview = 25,
    mappings = {
      go_in = "L",
      go_in_plus = "l",
      go_out = "H",
      go_out_plus = "h",
    },
  })

  local minifiles_toggle = function()
    if not MiniFiles.close() then
      MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
      MiniFiles.reveal_cwd()
    end
  end

  vim.api.nvim_create_user_command('MiniFilesToggle', minifiles_toggle, { desc = 'Toggle Mini Files' })


  local add_marks = function()
    MiniFiles.set_bookmark('c', vim.fn.stdpath('config'), { desc = 'Config' })
    local minideps_plugins = vim.fn.stdpath('data') .. '/site/pack/deps/opt'
    MiniFiles.set_bookmark('p', minideps_plugins, { desc = 'Plugins' })
    MiniFiles.set_bookmark('w', vim.fn.getcwd, { desc = 'Working directory' })
  end
  Config.new_autocmd('User', 'MiniFilesExplorerOpen', add_marks, 'Add bookmarks')
end)


now_if_args(function()
  require('mini.misc').setup()
  -- MiniMisc.setup_auto_root()
  MiniMisc.setup_restore_cursor()
  MiniMisc.setup_termbg_sync()
end)

-- Step two ===================================================================

later(function() require('mini.extra').setup() end)

later(function()
  local ai = require('mini.ai')
  ai.setup({
    custom_textobjects = {
      B = MiniExtra.gen_ai_spec.buffer(),
      F = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
    },
    search_method = 'cover',
  })
end)

-- later(function() require('mini.align').setup() end)
-- later(function() require('mini.animate').setup() end)
later(function() require('mini.bracketed').setup() end)
later(function() require('mini.bufremove').setup() end)

later(function()
  local miniclue = require('mini.clue')
  -- stylua: ignore
  miniclue.setup({
    -- Define which clues to show. By default shows only clues for custom mappings
    -- (uses `desc` field from the mapping; takes precedence over custom clue).
    clues = {
      -- This is defined in 'plugin/20_keymaps.lua' with Leader group descriptions
      Config.leader_group_clues,
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.square_brackets(),
      -- This creates a submode for window resize mappings. Try the following:
      -- - Press `<C-w>s` to make a window split.
      -- - Press `<C-w>+` to increase height. Clue window still shows clues as if
      --   `<C-w>` is pressed again. Keep pressing just `+` to increase height.
      --   Try pressing `-` to decrease height.
      -- - Stop submode either by `<Esc>` or by any key that is not in submode.
      miniclue.gen_clues.windows({ submode_resize = true }),
      miniclue.gen_clues.z(),
    },
    -- Explicitly opt-in for set of common keys to trigger clue window
    triggers = {
      { mode = { 'n', 'x' }, keys = '<Leader>' }, -- Leader triggers
      { mode = 'n',          keys = '\\' },       -- mini.basics
      { mode = { 'n', 'x' }, keys = '[' },        -- mini.bracketed
      { mode = { 'n', 'x' }, keys = ']' },
      { mode = 'i',          keys = '<C-x>' },    -- Built-in completion
      { mode = { 'n', 'x' }, keys = 'g' },        -- `g` key
      { mode = { 'n', 'x' }, keys = "'" },        -- Marks
      { mode = { 'n', 'x' }, keys = '`' },
      { mode = { 'n', 'x' }, keys = '"' },        -- Registers
      { mode = { 'i', 'c' }, keys = '<C-r>' },
      { mode = 'n',          keys = '<C-w>' },    -- Window commands
      { mode = { 'n', 'x' }, keys = 's' },        -- `s` key (mini.surround, etc.)
      { mode = { 'n', 'x' }, keys = 'z' },        -- `z` key
    },
  })
end)

-- later(function() require('mini.cmdline').setup() end)

later(function()
  require('mini.comment').setup({
    options = {
      custom_commentstring = function()
        return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
      end,
    },
  })
end)
later(function() require('mini.diff').setup() end)
later(function() require('mini.git').setup() end)
later(function()
  local hipatterns = require('mini.hipatterns')
  local hi_words = MiniExtra.gen_highlighter.words
  hipatterns.setup({
    highlighters = {
      -- Highlight a fixed set of common words. Will be highlighted in any place,
      -- not like "only in comments".
      fixme = hi_words({ 'FIXME', 'Fixme', 'fixme' }, 'MiniHipatternsFixme'),
      hack = hi_words({ 'HACK', 'Hack', 'hack' }, 'MiniHipatternsHack'),
      todo = hi_words({ 'TODO', 'Todo', 'todo' }, 'MiniHipatternsTodo'),
      note = hi_words({ 'NOTE', 'Note', 'note' }, 'MiniHipatternsNote'),

      -- Highlight hex color string (#aabbcc) with that color as a background
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })
end)

later(function()
  -- - `[i` / `]i` - navigate to scope's top / bottom
  require('mini.indentscope').setup({
    symbol = "▏",
    options = {
      try_as_border = true,
    },
    -- draw = {
    --   delay = 0,
    --   animation = require("mini.indentscope").gen_animation.none(),
    -- },

  })
end)


later(function() require('mini.jump').setup() end)

later(function() require('mini.jump2d').setup() end)
later(function()
  require('mini.keymap').setup()
  -- Navigate 'mini.completion' menu with `<Tab>` /  `<S-Tab>`
  MiniKeymap.map_multistep('i', '<Tab>', { 'pmenu_next' })
  MiniKeymap.map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
  -- On `<CR>` try to accept current completion item, fall back to accounting
  -- for pairs from 'mini.pairs'
  MiniKeymap.map_multistep('i', '<CR>', { 'pmenu_accept', 'minipairs_cr' })
  -- On `<BS>` just try to account for pairs from 'mini.pairs'
  MiniKeymap.map_multistep('i', '<BS>', { 'minipairs_bs' })
end)

later(function()
  local map = require('mini.map')
  map.setup({
    -- Use Braille dots to encode text
    symbols = { encode = map.gen_encode_symbols.dot('4x2') },
    -- Show built-in search matches, 'mini.diff' hunks, and diagnostic entries
    integrations = {
      map.gen_integration.builtin_search(),
      map.gen_integration.diff(),
      map.gen_integration.diagnostic(),
    },
  })

  -- Map built-in navigation characters to force map refresh
  for _, key in ipairs({ 'n', 'N', '*', '#' }) do
    local rhs = key
        -- Also open enough folds when jumping to the next match
        .. 'zv'
        .. '<Cmd>lua MiniMap.refresh({}, { lines = false, scrollbar = false })<CR>'
    vim.keymap.set('n', key, rhs)
  end
end)

-- later(function() require('mini.move').setup() end)
later(function()
  require('mini.operators').setup()
  vim.keymap.set('n', '(', 'gxiagxila', { remap = true, desc = 'Swap arg left' })
  vim.keymap.set('n', ')', 'gxiagxina', { remap = true, desc = 'Swap arg right' })
end)
later(function()
  require('mini.pairs').setup({ modes = { command = true } })
end)

later(function()
  require('mini.pick').setup({
    window = {
      config = function()
        height = math.floor(0.618 * vim.o.lines)
        width = math.floor(0.618 * vim.o.columns)
        return {
          border = "single",
          anchor = "NW",
          height = height,
          width = width,
          row = math.floor(0.5 * (vim.o.lines - height)),
          col = math.floor(0.5 * (vim.o.columns - width)),
        }
      end,
    },
    mappings = {
      delete_word = "<A-BS>",
      move_down = "<C-j>",
      move_up = "<C-k>",
    },
  })
end)
if false then
  later(function()
    local latex_patterns = { 'latex/**/*.json', '**/latex.json' }
    local lang_patterns = {
      tex = latex_patterns,
      plaintex = latex_patterns,
      -- Recognize special injected language of markdown tree-sitter parser
      markdown_inline = { 'markdown.json' },
    }

    local snippets = require('mini.snippets')
    local config_path = vim.fn.stdpath('config')
    snippets.setup({
      snippets = {
        -- Always load 'snippets/global.json' from config directory
        snippets.gen_loader.from_file(config_path .. '/snippets/global.json'),
        -- Load from 'snippets/' directory of plugins, like 'friendly-snippets'
        snippets.gen_loader.from_lang({ lang_patterns = lang_patterns }),
      },
    })
  end)
end
later(function() require('mini.splitjoin').setup() end)
later(function() require('mini.surround').setup() end)
later(function() require('mini.trailspace').setup() end)
later(function() require('mini.visits').setup() end)
