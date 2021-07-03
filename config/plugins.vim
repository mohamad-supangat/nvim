if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
call plug#begin('~/.local/share/nvim/plugged')

  Plug 'kyazdani42/nvim-web-devicons' " neovim web dev icon
 
  Plug 'christoomey/vim-tmux-navigator' " tmux navigation integration
    

  " lightline

  " Plug 'itchyny/lightline.vim'
  " Plug 'mengelbrecht/lightline-bufferline'
  " Plug 'itchyny/vim-cursorword'
  Plug 'akinsho/nvim-bufferline.lua'

  Plug 'sainnhe/gruvbox-material'
  " Plug 'lifepillar/vim-gruvbox8'

  " Plug 'pineapplegiant/spaceduck'
  " Plug 'rakr/vim-one'

  " Plug 'tjdevries/colorbuddy.nvim' " color scheme maker
  Plug 'rhysd/accelerated-jk' "navigate faster with jk
  Plug 'Yggdroot/indentLine' " show indentline
  " Plug 'lukas-reineke/indent-blankline.nvim' " indentLine
 
  Plug 'tpope/vim-commentary' " auto commennt 
  Plug 'AndrewRadev/tagalong.vim' " tag helper
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

  " language && syntax hightlight {{{
  let g:polyglot_disabled = ['vue']
  Plug 'sheerun/vim-polyglot' " solid syntax hightlight for  vim 
  Plug 'tweekmonster/startuptime.vim'

  Plug 'leafOfTree/vim-vue-plugin' " best vue integration

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

  Plug 'alvan/vim-closetag' " auto close html tag
  " Plug 'neoclide/coc-vetur' " vue language server from coc
  "
  Plug 'kdheepak/lazygit.nvim'
  Plug 'pablopunk/statusline.vim'

call plug#end()
 
