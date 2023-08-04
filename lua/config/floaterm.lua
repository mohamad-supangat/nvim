local status_ok, fterm = pcall(require, "FTerm")
if not status_ok then return end


local lazygit = fterm:new({
  cmd = "lazygit",
  -- blend = 20,
  border = 'double',
  dimensions = {
    height = 1,
    width = 1
  }
})

-- Use this to toggle gitui in a floating terminal
function _G.lazygit()
  lazygit:toggle()
end

local fterm1 = fterm:new({
  cmd = os.getenv('SHELL'),
  border = 'double',
  -- blend = 20,
  dimensions = {
    height = 1,
    width = 0.3,
    x = 0,
  }
})

local fterm2 = fterm:new({
  cmd = os.getenv('SHELL'),
  border = 'double',
  -- blend = 20,
  dimensions = {
    height = 1,
    width = 0.3,
    x = 1,
  }
})

function _G.fterm1()
  fterm1:toggle()
end

function _G.fterm2()
  fterm2:toggle()
end

-- keymaping
local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

map("n", "<A-i>", '<CMD>lua require("FTerm").toggle()<CR>', default_opts)
map("t", "<A-i>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', default_opts)

map("n", "<F1>", ":lua fterm1()<CR>", default_opts)
map("t", "<F1>", "<C-\\><C-n><CMD>lua fterm1()<CR>", default_opts)
map("n", "<F2>", ":lua fterm2()<CR>", default_opts)
map("t", "<F2>", "<C-\\><C-n><CMD>lua fterm2()<CR>", default_opts)
-- map("n", "<leader>git", ":lua lazygit()<CR>", default_opts)
