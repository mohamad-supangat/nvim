if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
call plug#begin('~/.local/share/nvim/plugged')
  " Plug 'gregsexton/MatchTag'
  
  let g:polyglot_disabled = ['typescript', 'vue', 'pug', 'python', 'php', 'markdown', 'dart', 'html', 'vim', 'json']
  Plug 'sheerun/vim-polyglot'
  Plug 'vim-airline/vim-airline'


  Plug 'kyazdani42/nvim-web-devicons' " neovim web dev icon
  Plug 'christoomey/vim-tmux-navigator' " tmux navigation integration

  Plug 'sainnhe/gruvbox-material'

  Plug 'rhysd/accelerated-jk' "navigate faster with jk
  Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'master' }

  Plug 'editorconfig/editorconfig-vim' " editorconfig for vim

  Plug 'preservim/tagbar'


  Plug 'junegunn/fzf', { 'build': './install --all', 'merged': 0 } " gui preview
  Plug 'junegunn/fzf.vim', { 'depends': 'fzf'}
  Plug 'neoclide/coc.nvim', {'branch': 'release'} " language server

  " Plug 'honza/vim-snippets' " snippets helpers for coc
  Plug 'rafamadriz/friendly-snippets' " snippets database for most language
  Plug 'mohamad-supangat/snippets' " My Custom snippet
  Plug 'antoinemadec/coc-fzf' " coc tui with fzf 


  Plug 'numToStr/FTerm.nvim'
  Plug 'rbgrouleff/bclose.vim' " closing buffer wisdthout pane

  Plug 'kdheepak/lazygit.nvim'
  Plug 'alvan/vim-closetag'

  Plug 'folke/todo-comments.nvim' " show todo comment

  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-pack/nvim-spectre' " search and replace

  Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
  Plug 'echasnovski/mini.nvim', { 'branch': 'stable' }

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'JoosepAlviste/nvim-ts-context-commentstring'
  Plug 'HiPhish/nvim-ts-rainbow2'
  
  Plug 'wellle/context.vim'

  
  Plug 'CRAG666/code_runner.nvim'
call plug#end()
