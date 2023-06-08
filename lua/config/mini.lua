-- local palette = require("mini.base16").mini_palette("#010101", "#efefef", 100)
--
-- require("mini.base16").setup({
--   palette = palette,
--   name = "minischeme",
--   use_cterm = true,
-- })
--

--
-- require("mini.base16").setup({
-- 	palette = require("colors.catppuccin"),
-- 	use_cterm = true,
-- })

--
-- require('mini.indentscope').setup({
--     draw = {
--         -- Delay (in ms) between event and start of drawing scope indicator
--         delay = 100
--
--         -- Animation rule for scope's first drawing. A function which, given next
--         -- and total step numbers, returns wait time (in ms). See
--         -- |MiniIndentscope.gen_animation()| for builtin options. To not use
--         -- animation, supply `require('mini.indentscope').gen_animation('none')`.
--         -- animation = --<function: implements constant 20ms between steps>,
--     },
--
--     -- Module mappings. Use `''` (empty string) to disable one.
--     mappings = {
--         -- Textobjects
--         object_scope = 'ii',
--         object_scope_with_border = 'ai',
--
--         -- Motions (jump to respective border line; if not present - body line)
--         goto_top = '[i',
--         goto_bottom = ']i'
--     },
--
--     -- Options which control computation of scope. Buffer local values can be
--     -- supplied in buffer variable `vim.b.miniindentscope_options`.
--     options = {
--         -- Type of scope's border: which line(s) with smaller indent to
--         -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
--         border = 'both',
--
--         -- Whether to use cursor column when computing reference indent. Useful to
--         -- see incremental scopes with horizontal cursor movements.
--         indent_at_cursor = true,
--
--         -- Whether to first check input line to be a border of adjacent scope.
--         -- Use it if you want to place cursor on function header to get scope of
--         -- its body.
--         try_as_border = true
--     },
--
--     -- Which character to use for drawing scope indicator
--     symbol = '▏'
-- })
--

local my_items = {
  -- { name = "Open FZF file finder",   action = "FzfLua files",                           section = "Builtin actions" },
  -- { name = "Open nvim tree",         action = "NvimTreeOpen",                           section = "Builtin actions" },
  { name = "Config: init.lua",       action = "e ~/.config/nvim/init.lua",              section = "Nvim" },
  { name = "Snippets: package.json", action = "e ~/.config/nvim/snippets/package.json", section = "Nvim" },
}

local starter = require("mini.starter")
starter.setup({
  autoopen = true,
  evaluate_single = true,
  items = {
    my_items,
    -- starter.sections.sessions(5, true), -- starter.sections.telescope(),
    starter.sections.builtin_actions(),
    starter.sections.recent_files(10, false),
    starter.sections.recent_files(10, true),
    -- Use this if you set up 'mini.sessions'
  },
  content_hooks = {
    starter.gen_hook.adding_bullet(),
    -- starter.gen_hook.aligning("center", "center"),
    starter.gen_hook.indexing("all", { "Builtin actions" }),
    starter.gen_hook.padding(10, 0),
  },
})

require("mini.comment").setup({
  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Toggle comment (like `gcip` - comment inner paragraph) for both
    -- Normal and Visual modes
    comment = "gc",
    -- Toggle comment on current line
    comment_line = "gcc",
    -- Define 'comment' textobject (like `dgc` - delete whole comment block)
    textobject = "gc",
  },
  -- Hook functions to be executed at certain stage of commenting
  hooks = {
    -- Before successful commenting. Does nothing by default.
    pre = function()
      -- require("ts_context_commentstring.internal").update_commentstring()
    end,
    -- After successful commenting. Does nothing by default.
    post = function()
    end,
  },
})

-- require("mini.cursorword").setup()
-- require("mini.trailspace").setup()

-- remove gui window separator for using global statusline
-- vim.cmd([[hi WinSeparator guibg=none]])
MiniStatusline = require("mini.statusline")
MiniStatusline.setup({
  set_vim_settings = false,
  context = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      local git = MiniStatusline.section_git({ trunc_width = 75 })
      local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
      local filename = MiniStatusline.section_filename({ trunc_width = 140 })
      local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
      local location = MiniStatusline.section_location({ trunc_width = 75 })
      return MiniStatusline.combine_groups({
        { hl = mode_hl,                 strings = { mode } },
        { hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
        "%<", -- Mark general truncate point
        { hl = "MiniStatuslineFilename", strings = { filename } },
        "%=", -- End left alignment
        { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
        { hl = mode_hl,                  strings = { location } },
      })
    end,
  },
})

require("mini.tabline").setup({
  -- Whether to show file icons (requires 'kyazdani42/nvim-web-devicons')
  show_icons = true,
  -- Whether to set Vim's settings for tabline (make it always shown and
  -- allow hidden buffers)
  set_vim_settings = true,
  -- Where to show tabpage section in case of multiple vim tabpages.
  -- One of 'left', 'right', 'none'.
  tabpage_section = "right",
})

--
-- require('mini.pairs').setup({
--     -- In which modes mappings from this `config` should be created
--     modes = {insert = true, command = false, terminal = false},
--
--     -- Global mappings. Each right hand side should be a pair information, a
--     -- table with at least these fields (see more in |MiniPairs.map|):
--     -- - <action> - one of 'open', 'close', 'closeopen'.
--     -- - <pair> - two character string for pair to be used.
--     -- By default pair is not inserted after `\`, quotes are not recognized by
--     -- `<CR>`, `'` does not insert pair after a letter.
--     -- Only parts of tables can be tweaked (others will use these defaults).
--     mappings = {
--         ['('] = {action = 'open', pair = '()', neigh_pattern = '[^\\].'},
--         ['['] = {action = 'open', pair = '[]', neigh_pattern = '[^\\].'},
--         ['{'] = {action = 'open', pair = '{}', neigh_pattern = '[^\\].'},
--
--         [')'] = {action = 'close', pair = '()', neigh_pattern = '[^\\].'},
--         [']'] = {action = 'close', pair = '[]', neigh_pattern = '[^\\].'},
--         ['}'] = {action = 'close', pair = '{}', neigh_pattern = '[^\\].'},
--
--         ['"'] = {
--             action = 'closeopen',
--             pair = '""',
--             neigh_pattern = '[^\\].',
--             register = {cr = false}
--         },
--         ["'"] = {
--             action = 'closeopen',
--             pair = "''",
--             neigh_pattern = '[^%a\\].',
--             register = {cr = false}
--         },
--         ['`'] = {
--             action = 'closeopen',
--             pair = '``',
--             neigh_pattern = '[^\\].',
--             register = {cr = false}
--         }
--     }
-- })
--
require("mini.surround").setup({
  -- Add custom surroundings to be used on top of builtin ones. For more
  -- information with examples, see `:h MiniSurround.config`.
  custom_surroundings = nil,
  -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
  highlight_duration = 500,
  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    add = "sa",            -- Add surrounding in Normal and Visual modes
    delete = "sd",         -- Delete surrounding
    find = "sf",           -- Find surrounding (to the right)
    find_left = "sF",      -- Find surrounding (to the left)
    highlight = "sh",      -- Highlight surrounding
    replace = "sr",        -- Replace surrounding
    update_n_lines = "sn", -- Update `n_lines`
  },
  -- Number of lines within which surrounding is searched
  n_lines = 20,
  -- How to search for surrounding (first inside current line, then inside
  -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
  -- 'cover_or_nearest'. For more details, see `:h MiniSurround.config`.
  search_method = "cover",
})

require("mini.bufremove").setup({ set_vim_settings = true })

