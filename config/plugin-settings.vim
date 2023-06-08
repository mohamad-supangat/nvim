" indent line {{{
let g:indent_blankline_char = '▏'

let g:indent_guides_auto_colors = 1
let g:indent_blankline_filetype_exclude = [
    \'defx',
    \'markdown',
    \'denite',
    \'startify',
    \'tagbar',
    \'vista_kind',
    \'vista'
      \]
" }}}
" let g:indent_blankline_use_treesitter = v:true
" let g:indent_blankline_show_end_of_line = v:true

" fzf settings {{{
let g:fzf_preview_window = []
let $FZF_DEFAULT_COMMAND = 'ag --hidden -U -g "" --ignore-dir={vendor,node_modules,.git}' " show hidden file in fzf

" Hide status bar while using fzf commands                                                                          
if has('nvim') || has('gui_running')                                                                                
  autocmd! FileType fzf                                                                                             
  autocmd  FileType fzf set laststatus=0 | autocmd WinLeave <buffer> set laststatus=2                               
endif
" }}}


" floating terminal plugin {{{
let g:floaterm_keymap_toggle = '<F1>'
" nnoremap <A-i> :FloatermToggle<CR>
let g:floaterm_keymap_next   = '<F2>'
let g:floaterm_keymap_prev   = '<F3>'
let g:floaterm_keymap_new    = '<F4>'

let g:floaterm_gitcommit='floaterm'
let g:floaterm_autoinsert=1
let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_wintitle=0
let g:floaterm_autoclose=1
" }}}


" startify config  {{{
let g:startify_lists = [
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'files',     'header': ['   MRU']            },
          \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ { 'type': 'commands',  'header': ['   Commands']       },
          \ ]
" }}}


" coc vim   {{{
" global extension for coc syncs
let g:coc_global_extensions = ['coc-git', 'coc-json', 'coc-marketplace', 'coc-pairs', 'coc-explorer', 'coc-snippets']
" }}}


let g:rainbow_active = 1 " active rainbow in every vim

" coc configuration {{{

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" }}}

" tagalong and close tag config
let g:tagalong_additional_filetypes = ['vue' , 'blade', "php", "xml"] " tagalong aditional fileype
let g:closetag_filetypes = 'html,xhtml,phtml,vue,blade,php,xml' " add vue to auto close html tag

" auto format .vue file on save / write
" autocmd BufWritePost *.vue :CocCommand prettier.formatFile
" }}}




" config status line
set statusline="  %{coc#status()}%{get(b:,'coc_current_function','')   %f %m %r %w %= Ln %l, Col %c  %{&fileencoding?&fileencoding:&encoding}  "
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

function! s:enter_explorer()
  if &filetype == 'coc-explorer'
    " statusline
    setl statusline=""
  endif
endfunction

augroup CocExplorerCustom
  autocmd!
  autocmd BufEnter * call <SID>enter_explorer()
  " autocmd FileType coc-explorer call <SID>init_explorer()
augroup END


" vim airline {{{
let g:airline#extensions#tabline#enabled = 1 " Use the airline tabline (replacement for buftabline)
let g:airline_theme = 'gruvbox_material'
let g:airline_powerline_fonts = 1
" }}}



" vim doge (document generator) {{{
let g:doge_filetype_aliases = {
\  'javascript': ['vue']
\}
let g:doge_mapping = '<Leader>nf'
" }}}


" polyglot {{{
" let g:vue_pre_processors = ['pug', 'scss']
let g:vue_pre_processors = 'detect_on_enter'
" }}}
