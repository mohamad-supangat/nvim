vim.g.mapleader   = ' '                              -- Use `<Space>` as <Leader> key
vim.o.clipboard   = "unnamedplus"
vim.o.mouse       = 'a'                              -- Enable mouse
vim.o.mousescroll = 'ver:25,hor:6'                   -- Customize mouse scroll
vim.o.switchbuf   = 'usetab'                         -- Use already opened buffers when switching
vim.o.undofile    = true                             -- Enable persistent undo
vim.o.backup      = false                            -- This is recommended by coc
vim.o.swapfile    = false
vim.o.writebackup = false                            -- This is recommended by coc
vim.o.shada       = "'100,<50,s10,:1000,/100,@100,h" -- Limit ShaDa file (for startup)

-- Enable all filetype plugins and syntax (if not enabled, for better startup)
vim.cmd('filetype plugin indent on')
if vim.fn.exists('syntax_on') ~= 1 then vim.cmd('syntax enable') end

-- UI =========================================================================
vim.o.breakindent    = true                -- Indent wrapped lines to match line start
vim.o.breakindentopt = 'list:-1'           -- Add padding for lists (if 'wrap' is set)
vim.o.colorcolumn    = '120'               -- Draw column on the right of maximum width
vim.o.cursorline     = true                -- Enable current line highlighting
vim.o.linebreak      = true                -- Wrap lines at 'breakat' (if 'wrap' is set)
vim.o.list           = true                -- Show helpful text indicators
vim.o.number         = true                -- Show line numbers
vim.o.pumheight      = 10                  -- Make popup menu smaller
vim.o.ruler          = false               -- Don't show cursor coordinates
vim.o.shortmess      = 'CFOSWaco'          -- Disable some built-in completion messages
vim.o.showmode       = false               -- Don't show mode in command line
vim.o.signcolumn     = 'yes'               -- Always show signcolumn (less flicker)
vim.o.splitbelow     = true                -- Horizontal splits will be below
vim.o.splitkeep      = 'screen'            -- Reduce scroll during window split
vim.o.splitright     = true                -- Vertical splits will be to the right
vim.o.winborder      = 'rounded'           -- Use border in floating windows
vim.o.wrap           = true                -- Don't visually wrap lines (toggle with \w)

vim.o.cursorlineopt  = 'screenline,number' -- Show cursor line per screen line
vim.o.laststatus     = 3                   -- global statusline
vim.o.cmdheight      = 1
vim.o.updatetime     = 100
-- Special UI symbols. More is set via 'mini.basics' later.
vim.o.fillchars      = 'eob: ,fold:╌'
vim.o.listchars      = 'extends:…,nbsp:␣,precedes:…,tab:> '
vim.opt.winbar       = "%= %#PmenuSel# %t "

-- Folds (see `:h fold-commands`, `:h zM`, `:h zR`, `:h zA`, `:h zj`)
vim.o.foldlevel      = 10       -- Fold nothing by default; set to 0 or 1 to fold
vim.o.foldmethod     = 'indent' -- Fold based on indent level
vim.o.foldnestmax    = 10       -- Limit number of fold levels
vim.o.foldtext       = ''       -- Show text under fold with its highlighting
vim.o.conceallevel   = 2


-- Editing ====================================================================
vim.o.autoindent    = true                  -- Use auto indent
vim.o.expandtab     = true                  -- Convert tabs to spaces
vim.o.formatoptions = 'rqnl1j'              -- Improve comment editing
vim.o.ignorecase    = true                  -- Ignore case during search
vim.o.incsearch     = true                  -- Show search matches while typing
vim.o.infercase     = true                  -- Infer case in built-in completion
vim.o.shiftwidth    = 2                     -- Use this number of spaces for indentation
vim.o.smartcase     = true                  -- Respect case if search pattern has upper case
vim.o.smartindent   = true                  -- Make indenting smart
vim.o.spelloptions  = 'camel'               -- Treat camelCase word parts as separate words
vim.o.tabstop       = 2                     -- Show tab as this number of spaces
vim.o.virtualedit   = 'block'               -- Allow going past end of line in blockwise mode

vim.o.iskeyword     = '@,48-57,_,192-255,-' -- Treat dash as `word` textobject part
if vim.fn.has("nvim-0.12.0") == 1 then
  require("vim._core.ui2").enable({})
end
-- stylua: ignore end
