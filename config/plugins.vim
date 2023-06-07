if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
call plug#begin('~/.local/share/nvim/plugged')
  " Plug 'gregsexton/MatchTag'
  Plug 'sheerun/vim-polyglot'
  Plug 'vim-airline/vim-airline'


  Plug 'kyazdani42/nvim-web-devicons' " neovim web dev icon
  Plug 'christoomey/vim-tmux-navigator' " tmux navigation integration
  Plug 'akinsho/nvim-bufferline.lua'

  Plug 'sainnhe/gruvbox-material'
  " Plug 'folke/tokyonight.nvim'
  " Plug 'NLKNguyen/papercolor-theme'

  Plug 'rhysd/accelerated-jk' "navigate faster with jk
  Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'master' }
  " Plug 'jasonccox/vim-wayland-clipboard'
  " Plug 'kana/vim-fakeclip'


  " Plug 'Yggdroot/indentLine'

  Plug 'tpope/vim-commentary' " auto commennt 
  Plug 'luochen1990/rainbow' " rinbow bracket
  Plug 'editorconfig/editorconfig-vim' " editorconfig for vim

  " Plug 'liuchengxu/vista.vim'
  Plug 'preservim/tagbar'


  Plug 'junegunn/fzf', { 'build': './install --all', 'merged': 0 } " gui preview
  Plug 'junegunn/fzf.vim', { 'depends': 'fzf'}
  Plug 'neoclide/coc.nvim', {'branch': 'release'} " language server

  Plug 'honza/vim-snippets' " snippets helpers for coc
  Plug "rafamadriz/friendly-snippets" " snippets database for most language
  Plug 'antoinemadec/coc-fzf' " coc tui with fzf 
 
  Plug 'mhinz/vim-startify' " start page for vim 

  Plug 'voldikss/vim-floaterm' " floating terminal
  Plug 'rbgrouleff/bclose.vim' " closing buffer wisdthout pane

  Plug 'kdheepak/lazygit.nvim'
  " Plug 'AndrewRadev/tagalong.vim'
  Plug 'alvan/vim-closetag'

  Plug 'folke/todo-comments.nvim' " show todo comment

  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-pack/nvim-spectre' " search and replace
  
  Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

call plug#end()
