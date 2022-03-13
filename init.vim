let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


set runtimepath^=/usr/share/vim/vimfiles

runtime config/plugins.vim
runtime config/main.vim
runtime config/plugin-settings.vim
runtime config/mappings.vim
runtime config/functions.vim
lua require('init')

