if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
call plug#begin('~/.local/share/nvim/plugged')
  " Plug 'gregsexton/MatchTag'
  Plug 'hoob3rt/lualine.nvim'
  Plug 'sheerun/vim-polyglot'

  Plug 'kyazdani42/nvim-web-devicons' " neovim web dev icon
  Plug 'christoomey/vim-tmux-navigator' " tmux navigation integration
  Plug 'akinsho/nvim-bufferline.lua'

  Plug 'sainnhe/gruvbox-material'
  " Plug 'folke/tokyonight.nvim'

  Plug 'rhysd/accelerated-jk' "navigate faster with jk
  Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'master' }

  Plug 'tpope/vim-commentary' " auto commennt 
  Plug 'luochen1990/rainbow' " rinbow bracket
  Plug 'editorconfig/editorconfig-vim' " editorconfig for vim

  Plug 'junegunn/fzf', { 'build': './install --all', 'merged': 0 } " gui preview
  Plug 'junegunn/fzf.vim', { 'depends': 'fzf'}
  Plug 'neoclide/coc.nvim', {'branch': 'release'} " language server

  Plug 'honza/vim-snippets' " snippets helpers for coc
  Plug 'antoinemadec/coc-fzf' " coc tui with fzf 
 
  Plug 'mhinz/vim-startify' " start page for vim 

  Plug 'voldikss/vim-floaterm' " floating terminal
  Plug 'rbgrouleff/bclose.vim' " closing buffer wisdthout pane

  Plug 'kdheepak/lazygit.nvim'
  Plug 'AndrewRadev/tagalong.vim'


call plug#end()
