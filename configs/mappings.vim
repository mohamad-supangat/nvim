"###################################################################################
"       __  ___                      _                    
"      /  |/  /____ _ ____   ____   (_)____   ____ _ _____
"     / /|_/ // __ `// __ \ / __ \ / // __ \ / __ `// ___/
"    / /  / // /_/ // /_/ // /_/ // // / / // /_/ /(__  ) 
"   /_/  /_/ \__,_// .___// .___//_//_/ /_/ \__, //____/  
"                 /_/    /_/               /____/         
"
"###################################################################################

"***********************************************************************************

" Main Vim Keybinds

"***********************************************************************************


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
map <ESC> :noh<cr>

"Faster ESC. {{{
inoremap jk <ESC>
inoremap kj <ESC>
inoremap jj <ESC>
"}}}

" Indent controls
" Reselect text ater indent/unindent.
vnoremap < <gv
vnoremap > >gv

" Tab to indent in visual mode.
vnoremap <Tab> >gv
" Shift+Tab to unindent in visual mode.
vnoremap <S-Tab> <gv

" Text alignment {{{
nnoremap <Leader>Al :left<CR>
nnoremap <Leader>Ac :center<CR>
nnoremap <Leader>Ar :right<CR>
vnoremap <Leader>Al :left<CR>
vnoremap <Leader>Ac :center<CR>
vnoremap <Leader>Ar :right<CR>
" }}}

"***********************************************************************************

" Plugin specific keybinds

"***********************************************************************************
 
" Git keybinds {{
" Git status
nnoremap  <Leader>gs  :Gstatus<cr>
" Git diff in split window
nnoremap  <Leader>gd  :Gdiffsplit<cr>
" Git commit
nnoremap  <Leader>gc  :Gcommit<cr>
" Git push 
nnoremap  <Leader>gP  :Gpush<cr>
" Git pull 
nnoremap  <Leader>gp  :Gpull<cr>
" Git move 
nnoremap  <Leader>gm  :Gmove<cr>
" Git merge 
nnoremap  <Leader>gM  :Gmerge<cr>
" browse current file on web
nnoremap  <Leader>gb  :Gbrowse<cr>
" browse current line on web
nnoremap  <Leader>gbl  :CocCommand git.browserOpen<cr>
" View chunk information in preview window. 
nnoremap  <Leader>gh  :CocCommand git.chunkInfo<cr>
" View commit information in preview window. 
nnoremap  <Leader>gsc  :CocCommand git.showCommit<cr>
" Toggle git gutter sign columns
nnoremap  <Leader>gg  :CocCommand git.toggleGutters<cr>
" Lazygit
nnoremap <silent> <Leader>git :LazyGit<CR>
" }}

" vim commenter plugin {{
nnoremap <space>/ :Commentary<CR>
vnoremap <space>/ :Commentary<CR>
" }}

" Vista {{{
" Opens tagbar on right side of screen
nmap <F8> :Vista!!<CR>
" }}} end of vista mapping

" vim-translator {{{
" Echo translation in the cmdline
nmap <silent> <Leader>t <Plug>Translate
vmap <silent> <Leader>t <Plug>TranslateV
" Display translation in a window
nmap <silent> <Leader>tw <Plug>TranslateW
vmap <silent> <Leader>tw <Plug>TranslateWV
" Replace the text with translation
nmap <silent> <Leader>tr <Plug>TranslateR
vmap <silent> <Leader>tr <Plug>TranslateRV
" }}} end of vim-translator plugins mapping

" Markdown preview 
nmap <Leader>md <Plug>MarkdownPreviewToggle

" vim-minimap controls {{{
let g:minimap_show='<leader>ms'
let g:minimap_update='<leader>mu'
let g:minimap_close='<leader>mc'
let g:minimap_toggle='<leader>mt'
" }}}

" easymotion commands {{{
map <Leader><Leader>. <Plug>(easymotion-repeat)
map <Leader><Leader>f <Plug>(easymotion-bd-f)
nmap <Leader><Leader>f <Plug>(easymotion-overwin-f)
nmap <Leader><Leader>s <Plug>(easymotion-overwin-f2)
nmap <Leader><Leader>j <Plug>(easymotion-overwin-line)

map <Leader><Leader>k <Plug>(easymotion-overwin-line)
map  <Leader><Leader>w <Plug>(easymotion-bd-w)
map <Leader><Leader>w <Plug>(easymotion-overwin-w)
" }}}

" Cut, Paste, Copy {{
vmap <C-x> d
vmap <C-v> p
vmap <C-c> y
" }}

" delete word when alt + backspace {{{
set backspace=indent,eol,start
imap <A-BS> <C-W>
" }}}

" select all {{
nmap <C-a> <Esc>ggVG
" }}

" undo redo {{{
nnoremap <C-Z> u
nnoremap <C-Y> <C-R>
inoremap <C-Z> <C-O>u
inoremap <C-Y> <C-O><C-R>
vnoremap <C-Z> <C-O>u
vnoremap <C-Y> <C-O><C-R>
" }}}

" FIXME: (broken) ctrl s to save {{{
noremap  <C-S> :w<CR>
vnoremap <C-S> <C-C>:w<CR>
inoremap <C-S> <Esc>:w<CR>
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
noremap <C-PageUp>  :bprevious<CR>
inoremap <C-PageUp>  <Esc>:bprevious<CR>i
nnoremap <C-PageDown>  :bnext<CR>
inoremap <C-PageDown>  <Esc>:bnext<CR>i

nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bb :bprevious<CR>
" nnoremap <Leader>bd :bdelete<CR> 
nnoremap <silent> <Leader>bd :Bclose<CR>

" bufferline pick function from nvim  bufferline
nnoremap <silent> gb :BufferLinePick<CR>

" }}}
" replacing tabs with buffer


" mapping delete witout cut / copy to buffer {{{
nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP
vmap <BS> "_d
" }}}

" Smooth scrooling {{{
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
" }}}

" coc && fzf keybinds {{
" toogle explorer
nmap <F7> :CocCommand explorer<CR>
" toogle fzf coc
nmap <leader>coc :CocFzfList<CR>
nmap <leader>P :CocFzfList commands<CR>
" }}


" nvim bufferline change by num
" nnoremap <leader> :lua require"bufferline".go_to_buffer(num)<CR>

