" indent line {{{
let g:indentLine_char = '▏'
" let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indent_blankline_char = '▏'

let g:indent_guides_auto_colors = 1
let g:indentLine_fileTypeExclude = [
    \'defx',
    \'markdown',
    \'denite',
    \'startify',
    \'tagbar',
    \'vista_kind',
    \'vista'
      \]
" }}}

" fzf settings {{{
let g:fzf_preview_window = []
let $FZF_DEFAULT_COMMAND = 'ag --hidden --depth 10 --ignore .git -f -g ""' " show hidden file in fzf

" Hide status bar while using fzf commands                                                                          
if has('nvim') || has('gui_running')                                                                                
  autocmd! FileType fzf                                                                                             
  autocmd  FileType fzf set laststatus=0 | autocmd WinLeave <buffer> set laststatus=2                               
endif
" }}}


" floating terminal plugin {{{
let g:floaterm_keymap_toggle = '<F1>'
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
let g:coc_global_extensions = ['coc-git', 'coc-json', 'coc-marketplace', 'coc-pairs', 'coc-explorer']

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c
" }}}


" completion nvim {{{
" lua require'nvim_lsp'.pyls.setup{on_attach=require'completion'.on_attach}
" let g:completion_enable_snippet = 'vim-vsnip'
" }}}

" let g:vim_vue_plugin_load_full_syntax = 1 " enable vue for full syntax
let g:LanguageClient_serverCommands = {
    \ 'vue': ['vls']
    \ }

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
let g:tagalong_additional_filetypes = ['vue' , 'blade'] " tagalong aditional fileype
let g:closetag_filetypes = 'html,xhtml,phtml,vue,blade' " add vue to auto close html tag


" some vue plugin config {{{
" let g:vim_vue_plugin_use_sass = 1
" " let g:vim_vue_plugin_highlight_vue_keyword = 1
" let g:vim_vue_plugin_highlight_vue_attr	= 1
" let g:vim_vue_plugin_has_init_indent = 1

let g:vim_vue_plugin_config = { 
      \'syntax': {
      \   'template': ['html', 'pug'],
      \   'script': ['javascript', 'typescript', 'coffee'],
      \   'style': ['scss', 'sass', 'less', 'stylus'],
      \   'i18n': ['json', 'yaml'],
      \   'route': 'json',
      \   'docs': 'markdown',
      \   'page-query': 'graphql',
      \},
      \'full_syntax': ['scss', 'html'],
      \'initial_indent': ['script.javascript', 'style', 'yaml'],
      \'attribute': 1,
      \'keyword': 1,
      \'foldexpr': 0,
      \}

autocmd FileType vue inoremap <buffer><expr> : InsertColon()

function! InsertColon()
  let tag = GetVueTag()
  return tag == 'template' ? ':' : ': '
endfunction

function! OnChangeVueSyntax(syntax)
  " echom 'Syntax is '.a:syntax
  if a:syntax == 'html'
    setlocal commentstring=<!--%s-->
    setlocal comments=s:<!--,m:\ \ \ \ ,e:-->
  elseif a:syntax =~ 'css'
    setlocal comments=s1:/*,mb:*,ex:*/ commentstring&
  else
    setlocal commentstring=//%s
    setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
  endif
endfunction

" auto format .vue file on save / write
autocmd BufWritePost *.vue :CocCommand prettier.formatFile
" }}}


" lua require('nvim-biscuits').setup({})
