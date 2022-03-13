" mapping config {{{
" Set leader to space bar
let mapleader = " "
let maplocalleader = " "

" Window Navigation {{{
" Navigate to left window.
nnoremap <C-h> <C-w>h
" Navigate to down window.
nnoremap <C-j> <C-w>j
" Navigate to top window.
nnoremap <C-k> <C-w>k
" Navigate to right window.
nnoremap <C-l> <C-w>l
" Horizontal split then move to bottom window.
nnoremap <Leader>- <C-w>s
" Vertical split then move to right window.
nnoremap <Leader>\| <C-w>v<C-w>l
" }}}

" Change Y to copy to end of line and behave like C
nnoremap Y y$

" map esc / exit insert mode && clear higthlight search
" map <ESC> :noh<cr>
nnoremap <esc><esc> :noh<return>

" accelerated  jk for fastest moving {{{
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
" }}}

"Faster ESC. {{{
inoremap <silent><nowait>  jk <ESC>
inoremap <silent><nowait>  kj <ESC>
inoremap <silent><nowait>  jj <ESC>
"}}}

" Indent controls
" Reselect text ater indent/unindent.
vnoremap <silent><nowait>  < <gv
vnoremap <silent><nowait>  > >gv

" Tab to indent in visual mode.
vnoremap  <silent><nowait> <Tab> >gv
" Shift+Tab to unindent in visual mode.
vnoremap  <silent><nowait> <S-Tab> <gv

" Text alignment {{{
nnoremap <Leader>Al :left<CR>
nnoremap <Leader>Ac :center<CR>
nnoremap <Leader>Ar :right<CR>
vnoremap <Leader>Al :left<CR>
vnoremap <Leader>Ac :center<CR>
vnoremap <Leader>Ar :right<CR>
" }}}

" Lazygit
" nnoremap <silent> <Leader>git :call ToggleLazyGit()<CR>
nnoremap <silent> <Leader>git :LazyGit<CR>

" }}

" vim commenter plugin {{
nnoremap <silent> <Leader>nin :Commentary<CR>
vnoremap <silent> <Leader>nin :Commentary<CR>
nnoremap <C-/> :Commentary<CR>
vnoremap <C-/> :Commentary<CR>
nnoremap cic :Commentary<CR>
vnoremap cic :Commentary<CR>
vnoremap / :Commentary<CR>
" }}

" Vista {{{
" Opens tagbar on right side of screen
nmap <F8> :Vista!!<CR>
" }}} end of vista mapping

" Markdown preview 
nmap <Leader>md <Plug>MarkdownPreviewToggle

" Cut, Paste, Copy {{
vmap <silent><nowait>  <C-x> d
vmap <silent><nowait>  <C-v> p
nmap <silent><nowait>  <C-v> p
imap <silent><nowait>  <C-v> <ESC>pi
vmap <silent><nowait>  <C-c> y
" }}

" delete word when alt + backspace {{{
set backspace=indent,eol,start
imap <silent><nowait>  <A-BS> <C-W>
" }}}

" select all {{
nmap <C-a> <Esc>ggVG
" }}

" undo redo {{{
" nnoremap <silent><nowait>  <C-Z> u
" nnoremap <silent><nowait>  <C-Y> <C-R>
" inoremap <silent><nowait>  <C-Z> <C-O>u
" inoremap <silent><nowait>  <C-Y> <C-O><C-R>
" vnoremap <silent><nowait>  <C-Z> <C-O>u
" vnoremap <silent><nowait>  <C-Y> <C-O><C-R>
" }}}

" FIXME: (broken) ctrl s to save {{{
noremap <silent><nowait>   <C-S> :update<CR>
vnoremap <silent><nowait>  <C-S> <C-C>:update<CR>
inoremap <silent><nowait>  <C-S> <Esc>:update<CR>
" }}}


" shift+arrow selection {{{
nmap <S-Up> v<Up>
nmap <S-Down> v<Down>
nmap <S-Left> v<Left>
nmap <S-Right> v<Right>
vmap <S-Up> <Up>
vmap <S-Down> <Down>
vmap <S-Left> <Left>
vmap <S-Right> <Right>
imap <S-Up> <Esc>v<Up>
imap <S-Down> <Esc>v<Down>
imap <S-Lef> <Esc>v<Left>
imap <S-Right> <Esc>v<Right>
" }}}

" shortcut for far.vim find {{{
nnoremap <silent> <Find-Shortcut>  :Farf<cr>
vnoremap <silent> <Find-Shortcut>  :Farf<cr>

" shortcut for far.vim replace
nnoremap <silent> <leader>h :Farr<cr>
vnoremap <silent> <leader>h :Farr<cr>
" }}}

" map ctrl + p fuzy filefinder
map <C-p> :Files<CR>

" Tabs {{{
nnoremap <C-t>  :enew<CR>
inoremap <C-t>  <Esc>:enew<CR>i
nnoremap <C-PageUp>  :bprevious<CR>
" inoremap <C-J>  <Esc>:bprevious<CR>i
nnoremap <C-PageDown> :bnext<CR>
" inoremap <C-K>  <Esc>:bnext<CR>i
nnoremap <C-S-Tab>  :bprevious<CR>
" inoremap <C-J>  <Esc>:bprevious<CR>i
nnoremap <C-Tab> :bnext<CR>

nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bb :bprevious<CR>
" nnoremap <Leader>bd :bdelete<CR> 
nnoremap <silent> <Leader>bd :Bclose<CR>

" bufferli pick function from nvim  bufferli
nnoremap <silent> gb :BufferLinePic<CR>

" }}}
" replacing tabs with buffer


" mapping : delete witout cut / copy to buffer {{{
vmap <BS> "_d
" }}}

" coc && fzf keybinds {{

" toogle explorer
nnoremap <C-n> :CocCommand explorer<CR>

" toogle fzf coc
nmap <leader>coc :CocFzfList<CR>
nmap <leader>P :CocFzfList commands<CR>

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" multiple cursor
nmap <silent> <C-c> <Plug>(coc-cursors-position)
nmap <silent> <C-d> <Plug>(coc-cursors-word)
xmap <silent> <C-d> <Plug>(coc-cursors-range)
" }}}


