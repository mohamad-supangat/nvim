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
      require("ts_context_commentstring.internal").update_commentstring()
    end,
    -- After successful commenting. Does nothing by default.
    post = function()
    end,
  },
})


require("mini.surround").setup()
require("mini.bufremove").setup({ set_vim_settings = true })

