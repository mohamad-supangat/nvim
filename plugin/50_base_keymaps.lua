-- ┌─────────────────┐
-- │ Custom mappings │
-- └─────────────────┘

-- General mappings ===========================================================

-- Multi-mode mappings
vim.keymap.set({ "i", "t", "v", "c" }, "<A-BS>", "<C-W>",
  { noremap = true, silent = true, desc = "delete word" })

vim.keymap.set("v", "<BS>", '"_d',
  { noremap = true, silent = true, desc = "Delete without cut /copy to buffer clipboard" })

-- Normal mode mappings
vim.keymap.set("n", "[p", '<Cmd>exe "put! " . v:register<CR>',
  { noremap = true, silent = true, desc = "Paste Above" })

vim.keymap.set("n", "]p", '<Cmd>exe "put "  . v:register<CR>',
  { noremap = true, silent = true, desc = "Paste Below" })

vim.keymap.set("n", "<Esc><Esc>", ":nohl<CR>",
  { noremap = true, silent = true, desc = "Remove Search highlighting" })

vim.keymap.set("n", "<C-a>", "<Esc>ggVG",
  { noremap = true, silent = true, desc = "Select All Text in current file" })

-- Visual mode mappings
vim.keymap.set("v", "<Tab>", ">gv",
  { noremap = true, silent = true, desc = "Indent >" })

vim.keymap.set("v", "<S-Tab>", "<gv",
  { noremap = true, silent = true, desc = "Indent <" })

vim.keymap.set("v", ">", ">gv",
  { noremap = true, silent = true, desc = "Indent >" })

vim.keymap.set("v", "<", "<gv",
  { noremap = true, silent = true, desc = "Indent <" })

-- Leader mappings
vim.keymap.set("n", "<Leader>uu", "<Cmd>DepsUpdate<CR>",
  { noremap = true, silent = true, desc = "Update Plugins" })

vim.keymap.set("n", "<Leader>q", ":q<CR>",
  { noremap = true, silent = true, desc = "Exit neovim" })

vim.keymap.set("n", "<Leader>qa", ":quitall!<CR>",
  { noremap = true, silent = true, desc = "Force Exit" })

vim.keymap.set("n", "<leader>cf", function()
  local filepath = vim.fn.expand("%")
  vim.fn.setreg("+", filepath)
  vim.notify("Copied filepath to clipboard")
end, { noremap = true, silent = true, desc = "Copy File Path to clipboard" })

vim.keymap.set("n", "<leader>-", "<C-w>s",
  { noremap = true, silent = true, desc = "Split window horizontal" })

vim.keymap.set("n", "<leader>|", "<C-w>v<C-w>l",
  { noremap = true, silent = true, desc = "Split window vertical" })

vim.keymap.set("v", "/", '"fy/\\V<C-R>f<CR>',
  { noremap = true, silent = true, desc = "Search current tag" })

vim.keymap.set("n", "<leader>cd", ":cd %:p:h<CR>",
  { noremap = true, silent = true, desc = "Change dir to current opened file" })

vim.keymap.set("n", "<leader>sm", function()
  vim.cmd("!sublime_merge " .. require("utils").currentFileRootPath() .. "&")
end, { noremap = true, silent = true, desc = "Buka Sublime Merge" })

vim.keymap.set("n", "<leader>na", function()
  vim.cmd("!nautilus " .. require("utils").currentFileRootPath() .. "&")
end, { noremap = true, silent = true, desc = "Buka File Manager nautilus" })

-- Buffer management
local new_scratch_buffer = function()
  vim.api.nvim_win_set_buf(0, vim.api.nvim_create_buf(true, true))
end

vim.keymap.set("n", "<C-t>", "<Cmd>enew<CR>",
  { noremap = true, silent = true, desc = "New Buffer" })

vim.keymap.set("n", "<Leader>ba", "<Cmd>b#<CR>",
  { noremap = true, silent = true, desc = "Alternate" })

vim.keymap.set("n", "<Leader>bd", "<Cmd>lua MiniBufremove.delete()<CR>",
  { noremap = true, silent = true, desc = "Delete" })

vim.keymap.set("n", "<Leader>bD", "<Cmd>lua MiniBufremove.delete(0, true)<CR>",
  { noremap = true, silent = true, desc = "Delete!" })

vim.keymap.set("n", "<Leader>bn", "<Cmd>bnext<CR>",
  { noremap = true, silent = true, desc = "Next" })

vim.keymap.set("n", "<Leader>bb", "<Cmd>bprev<CR>",
  { noremap = true, silent = true, desc = "Prev" })

vim.keymap.set("n", "<Leader>bs", new_scratch_buffer,
  { noremap = true, silent = true, desc = "Scratch" })

vim.keymap.set("n", "<Leader>bw", "<Cmd>lua MiniBufremove.wipeout()<CR>",
  { noremap = true, silent = true, desc = "Wipeout" })

vim.keymap.set("n", "<Leader>bW", "<Cmd>lua MiniBufremove.wipeout(0, true)<CR>",
  { noremap = true, silent = true, desc = "Wipeout!" })

-- Explore mappings
local explore_at_file = '<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>'
local explore_quickfix = function()
  vim.cmd(vim.fn.getqflist({ winid = true }).winid ~= 0 and 'cclose' or 'copen')
end
local explore_locations = function()
  vim.cmd(vim.fn.getloclist(0, { winid = true }).winid ~= 0 and 'lclose' or 'lopen')
end

vim.keymap.set("n", "<c-n>", "<Cmd>MiniFilesToggle<CR>",
  { noremap = true, silent = true, desc = "Directory" })

vim.keymap.set("n", "<Leader>ef", explore_at_file,
  { noremap = true, silent = true, desc = "File directory" })

vim.keymap.set("n", "<Leader>ei", "<Cmd>edit $MYVIMRC<CR>",
  { noremap = true, silent = true, desc = "init.lua" })

vim.keymap.set("n", "<Leader>en", "<Cmd>lua MiniNotify.show_history()<CR>",
  { noremap = true, silent = true, desc = "Notifications" })

vim.keymap.set("n", "<Leader>eq", explore_quickfix,
  { noremap = true, silent = true, desc = "Quickfix list" })

vim.keymap.set("n", "<Leader>eQ", explore_locations,
  { noremap = true, silent = true, desc = "Location list" })

-- Pick/Fuzzy find mappings
local pick_added_hunks_buf = '<Cmd>Pick git_hunks path="%" scope="staged"<CR>'
local pick_workspace_symbols_live = '<Cmd>Pick lsp scope="workspace_symbol_live"<CR>'

vim.keymap.set("n", "<Leader>fb", "<Cmd>Pick buffers<CR>",
  { noremap = true, silent = true, desc = "Buffers" })

vim.keymap.set("n", "<Leader>fc", "<Cmd>Pick git_commits<CR>",
  { noremap = true, silent = true, desc = "Commits (all)" })

vim.keymap.set("n", "<Leader>fC", "<Cmd>Pick git_commits path=\"%\"<CR>",
  { noremap = true, silent = true, desc = "Commits (buf)" })

vim.keymap.set("n", "<Leader>fd", "<Cmd>Pick diagnostic scope=\"all\"<CR>",
  { noremap = true, silent = true, desc = "Diagnostic workspace" })

vim.keymap.set("n", "<Leader>fD", "<Cmd>Pick diagnostic scope=\"current\"<CR>",
  { noremap = true, silent = true, desc = "Diagnostic buffer" })

vim.keymap.set("n", "<Leader>fh", "<Cmd>Pick help<CR>",
  { noremap = true, silent = true, desc = "Help tags" })

vim.keymap.set("n", "<Leader>fl", "<Cmd>Pick buf_lines scope=\"all\"<CR>",
  { noremap = true, silent = true, desc = "Lines (all)" })

vim.keymap.set("n", "<Leader>fL", "<Cmd>Pick buf_lines scope=\"current\"<CR>",
  { noremap = true, silent = true, desc = "Lines (buf)" })

vim.keymap.set("n", "<Leader>fs", pick_workspace_symbols_live,
  { noremap = true, silent = true, desc = "Symbols workspace (live)" })

vim.keymap.set("n", "<Leader>fS", "<Cmd>Pick lsp scope=\"document_symbol\"<CR>",
  { noremap = true, silent = true, desc = "Symbols document" })

vim.keymap.set("n", "<Leader>fv", "<Cmd>Pick visit_paths cwd=\"\"<CR>",
  { noremap = true, silent = true, desc = "Visit paths (all)" })

vim.keymap.set("n", "<Leader>fV", "<Cmd>Pick visit_paths<CR>",
  { noremap = true, silent = true, desc = "Visit paths (cwd)" })

vim.keymap.set("n", "<C-p>", function()
  require('mini.pick').builtin.cli({
    command = {
      "rg",
      "--files",
      "--hidden",
      "-uu",
      "-g",
      "!/**/.git",
      "-g",
      "!/**/node_modules",
      "-g",
      "!/vendor",
      "-g",
      "!/public/build",
      "-g",
      "!*.{jpg,jpeg,png,gif,bmp,tiff,mov,mp4,avi,mpeg,webm,pdf,doc,docx,mp3,cache,gitkeep,gitignore}",
    },
  })
end, { noremap = true, silent = true, desc = "Pick Files" })

-- Git mappings
local git_log_cmd = [[Git log --pretty=format:\%h\ \%as\ │\ \%s --topo-order]]
local git_log_buf_cmd = git_log_cmd .. ' --follow -- %'

vim.keymap.set("n", "<Leader>gl", "<Cmd>" .. git_log_cmd .. "<CR>",
  { noremap = true, silent = true, desc = "Log" })

vim.keymap.set("n", "<Leader>gL", "<Cmd>" .. git_log_buf_cmd .. "<CR>",
  { noremap = true, silent = true, desc = "Log buffer" })

vim.keymap.set("n", "<Leader>go", "<Cmd>lua MiniDiff.toggle_overlay()<CR>",
  { noremap = true, silent = true, desc = "Toggle overlay" })

vim.keymap.set("n", "<Leader>gs", "<Cmd>lua MiniGit.show_at_cursor()<CR>",
  { noremap = true, silent = true, desc = "Show at cursor" })

vim.keymap.set("x", "<Leader>gs", "<Cmd>lua MiniGit.show_at_cursor()<CR>",
  { noremap = true, silent = true, desc = "Show at selection" })


-- LSP mappings
vim.keymap.set("n", "ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>",
  { noremap = true, silent = true, desc = "Actions" })

vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { desc = 'LSP signature help' })

vim.keymap.set("n", "gl", "<Cmd>lua vim.diagnostic.open_float()<CR>",
  { noremap = true, silent = true, desc = "Diagnostic popup" })

vim.keymap.set("n", "<Leader>fm", "<Cmd>Format<CR>",
  { noremap = true, silent = true, desc = "Format" })

vim.keymap.set("x", "<Leader>fm", "<Cmd>Format<CR>",
  { noremap = true, silent = true, desc = "Format selection" })

vim.keymap.set("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>",
  { noremap = true, silent = true, desc = "Hover" })

vim.keymap.set("n", "rn", "<Cmd>lua vim.lsp.buf.rename()<CR>",
  { noremap = true, silent = true, desc = "Rename" })

vim.keymap.set("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>",
  { noremap = true, silent = true, desc = "References" })

vim.keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>",
  { noremap = true, silent = true, desc = "Source definition" })

vim.keymap.set("n", "go", "<Cmd>lua vim.lsp.buf.type_definition()<CR>",
  { noremap = true, silent = true, desc = "Type definition" })

-- Mini.map mappings
vim.keymap.set("n", "<Leader>mf", "<Cmd>lua MiniMap.toggle_focus()<CR>",
  { noremap = true, silent = true, desc = "Focus (toggle)" })

vim.keymap.set("n", "<Leader>mr", "<Cmd>lua MiniMap.refresh()<CR>",
  { noremap = true, silent = true, desc = "Refresh" })

vim.keymap.set("n", "<Leader>ms", "<Cmd>lua MiniMap.toggle_side()<CR>",
  { noremap = true, silent = true, desc = "Side (toggle)" })

vim.keymap.set("n", "<Leader>mt", "<Cmd>lua MiniMap.toggle()<CR>",
  { noremap = true, silent = true, desc = "Toggle" })

-- Other mappings
vim.keymap.set("n", "<Leader>or", "<Cmd>lua MiniMisc.resize_window()<CR>",
  { noremap = true, silent = true, desc = "Resize to default width" })

vim.keymap.set("n", "<Leader>ot", "<Cmd>lua MiniTrailspace.trim()<CR>",
  { noremap = true, silent = true, desc = "Trim trailspace" })

vim.keymap.set("n", "<c-z>", "<Cmd>lua MiniMisc.zoom()<CR>",
  { noremap = true, silent = true, desc = "Zoom toggle / Zen Mode" })

-- Session mappings
local session_new = 'MiniSessions.write(vim.fn.input("Session name: "))'

vim.keymap.set("n", "<Leader>sd", "<Cmd>lua MiniSessions.select(\"delete\")<CR>",
  { noremap = true, silent = true, desc = "Delete" })

vim.keymap.set("n", "<Leader>sn", "<Cmd>lua " .. session_new .. "<CR>",
  { noremap = true, silent = true, desc = "New" })

vim.keymap.set("n", "<Leader>sr", "<Cmd>lua MiniSessions.select(\"read\")<CR>",
  { noremap = true, silent = true, desc = "Read" })

vim.keymap.set("n", "<Leader>sw", "<Cmd>lua MiniSessions.write()<CR>",
  { noremap = true, silent = true, desc = "Write current" })

-- Terminal mappings
vim.keymap.set("n", "<Leader>tT", "<Cmd>horizontal term<CR>",
  { noremap = true, silent = true, desc = "Terminal (horizontal)" })

vim.keymap.set("n", "<Leader>tt", "<Cmd>vertical term<CR>",
  { noremap = true, silent = true, desc = "Terminal (vertical)" })

-- Visits mappings
local make_pick_core = function(cwd, desc)
  return function()
    local sort_latest = MiniVisits.gen_sort.default({ recency_weight = 1 })
    local local_opts = { cwd = cwd, filter = 'core', sort = sort_latest }
    MiniExtra.pickers.visit_paths(local_opts, { source = { name = desc } })
  end
end

vim.keymap.set("n", "<Leader>vc", make_pick_core('', 'Core visits (all)'),
  { noremap = true, silent = true, desc = "Core visits (all)" })

vim.keymap.set("n", "<Leader>vC", make_pick_core(nil, 'Core visits (cwd)'),
  { noremap = true, silent = true, desc = "Core visits (cwd)" })

vim.keymap.set("n", "<Leader>vv", "<Cmd>lua MiniVisits.add_label(\"core\")<CR>",
  { noremap = true, silent = true, desc = "Add \"core\" label" })

vim.keymap.set("n", "<Leader>vV", "<Cmd>lua MiniVisits.remove_label(\"core\")<CR>",
  { noremap = true, silent = true, desc = "Remove \"core\" label" })

vim.keymap.set("n", "<Leader>vl", "<Cmd>lua MiniVisits.add_label()<CR>",
  { noremap = true, silent = true, desc = "Add label" })

vim.keymap.set("n", "<Leader>vL", "<Cmd>lua MiniVisits.remove_label()<CR>",
  { noremap = true, silent = true, desc = "Remove label" })

-- Find and replace (Spectre/grug-far)
vim.keymap.set("n", "<leader>S", function()
  require("grug-far").open({ transient = true })
end, { noremap = true, silent = true, desc = "Toggle Spectre" })

vim.keymap.set({ "n", "v" }, "<leader>sw", function()
  require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
end, { noremap = true, silent = true, desc = "Search current word" })

vim.keymap.set("n", "<leader>sp", function()
  require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
end, { noremap = true, silent = true, desc = "Search on current file" })

vim.keymap.set("n", "<leader>sf", function()
  local currentFilePath = vim.api.nvim_buf_get_name(0)
  local currentFileDirectory = currentFilePath:match("(.*/)") or ""
  require("grug-far").open({ prefills = { paths = currentFileDirectory } })
end, { noremap = true, silent = true, desc = "Toggle Spectre Current Folder" })

-- Smart splits mappings
vim.keymap.set("n", "<A-h>", require('smart-splits').resize_left,
  { noremap = true, silent = true, desc = "Resize left" })

vim.keymap.set("n", "<A-j>", require('smart-splits').resize_down,
  { noremap = true, silent = true, desc = "Resize down" })

vim.keymap.set("n", "<A-k>", require('smart-splits').resize_up,
  { noremap = true, silent = true, desc = "Resize up" })

vim.keymap.set("n", "<A-l>", require('smart-splits').resize_right,
  { noremap = true, silent = true, desc = "Resize right" })

vim.keymap.set("n", "<C-h>", require('smart-splits').move_cursor_left,
  { noremap = true, silent = true, desc = "Move cursor left" })

vim.keymap.set("n", "<C-j>", require('smart-splits').move_cursor_down,
  { noremap = true, silent = true, desc = "Move cursor down" })

vim.keymap.set("n", "<C-k>", require('smart-splits').move_cursor_up,
  { noremap = true, silent = true, desc = "Move cursor up" })

vim.keymap.set("n", "<C-l>", require('smart-splits').move_cursor_right,
  { noremap = true, silent = true, desc = "Move cursor right" })

vim.keymap.set("n", "<C-\\>", require('smart-splits').move_cursor_previous,
  { noremap = true, silent = true, desc = "Move cursor previous" })

vim.keymap.set("n", "<leader><leader>h", require('smart-splits').swap_buf_left,
  { noremap = true, silent = true, desc = "Swap buffer left" })

vim.keymap.set("n", "<leader><leader>j", require('smart-splits').swap_buf_down,
  { noremap = true, silent = true, desc = "Swap buffer down" })

vim.keymap.set("n", "<leader><leader>k", require('smart-splits').swap_buf_up,
  { noremap = true, silent = true, desc = "Swap buffer up" })

vim.keymap.set("n", "<leader><leader>l", require('smart-splits').swap_buf_right,
  { noremap = true, silent = true, desc = "Swap buffer right" })

-- Obsidian keymaps
vim.keymap.set("n", "<leader>no", ":Obsidian<CR>",
  { noremap = true, silent = true, desc = "Obsidian" })

vim.keymap.set("n", "<Leader>nk", function()
  MiniPick.builtin.files({}, {
    source = {
      name = 'Obsidian Notes',
      cwd = vim.fn.expand('~/Documents/Obsidian/'),
    },
  })
end, { noremap = true, silent = true, desc = "Obsidian notes picker" })

-- Git auto commit
vim.keymap.set("n", "<leader>gc", require('utils').GitAutoCommit,
  { noremap = true, silent = true, desc = "Git: Auto commit dan push" })

-- Nvim scissors mappings
vim.keymap.set("n", "<leader>sne", function()
  require("scissors").editSnippet()
end, { noremap = true, silent = true, desc = "Edit snippet" })

vim.keymap.set({ "n", "x" }, "<leader>sna", function()
  require("scissors").addNewSnippet()
end, { noremap = true, silent = true, desc = "Add new snippet" })

-- Neogen keymap
vim.keymap.set("n", "<Leader>nf", function()
  require('neogen').generate()
end, { noremap = true, silent = true, desc = "Generate documentation" })
