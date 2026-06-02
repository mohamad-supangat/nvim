local later = MiniDeps.later

-- {{{ mini.completion
local config = require("config_reader").read_config()

if config.completion.mini then
  later(function()
    vim.o.pumblend = 5

    -- setup cmdline juga
    require('mini.cmdline').setup()

    -- local process_items_opts = { kind_priority = { Text = -1, Snippet = -2 } }
    -- local process_items = function(items, base)
    --   return MiniCompletion.default_process_items(items, base, process_items_opts)
    -- end

    require("mini.completion").setup({
      window = {
        info = { height = 30, width = 80, border = "rounded" },
        signature = { height = 30, width = 80, border = "rounded" },
      },
      lsp_completion = {
        source_func = 'omnifunc',
        auto_setup = true,
        -- process_items = process_items,

      },
    })

    local on_attach = function(ev)
      vim.bo[ev.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
    end
    Config.new_autocmd('LspAttach', nil, on_attach, "Set 'omnifunc'")


    -- local function check_last_char()
    --   local line = vim.api.nvim_get_current_line()
    --   local cursor_col = vim.api.nvim_win_get_cursor(0)[2]
    --   local last_char = string.sub(line, cursor_col, cursor_col)
    --   if last_char == "{" then
    --     vim.b.minicompletion_disable = true
    --   else
    --     vim.b.minicompletion_disable = false
    --   end
    -- end
    vim.api.nvim_create_augroup("InsertBraceGroup", { clear = true })
    -- vim.api.nvim_create_autocmd("TextChangedI", {
    --   group = "InsertBraceGroup",
    --   callback = check_last_char,
    -- })


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
  end)
end
-- }}} end mini.completion
