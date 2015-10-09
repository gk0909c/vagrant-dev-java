set number
set title
set ambiwidth=double
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smartindent
set autoindent
set backspace=indent,eol,start
set noswapfile
set nobackup
set noundofile
set cursorline
hi clear CursorLine
hi CursorLineNr term=bold cterm=NONE ctermfg=228 ctermbg=NONE

augroup vimrc
  autocmd! FileType java setlocal shiftwidth=4 tabstop=4 softtabstop=4
augroup END

""" NeoBundle """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'

call neobundle#end()

NeoBundleCheck

""" Eclim """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype plugin indent on

augroup EclimAu
  autocmd!
  autocmd FileType java nnoremap <silent> <buffer> <leader>i :JavaImport<cr>
  autocmd FileType java nnoremap <silent> <buffer> <cr> :JavaSearchContext<cr>
  autocmd FileType java let g:EclimJavaSearchSingleResult = 'edit'
augroup END

set completeopt=longest,menuone
set completeopt-=preview

""" neosnippet """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:neocomplete#enable_at_startup = 1

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

""" Color Scheme """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set background=dark
colorscheme hybrid

""" auto make directory """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrc-auto-mkdir  " {{{
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)  " {{{
    if !isdirectory(a:dir) && (a:force ||
    \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction  " }}}
augroup END  " }}}

""" tab(tc, tx, tn, tp, tn(n=1,2,3,,,,)) """""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand('~/.vimrc_tab'))
  source ~/.vimrc_tab
endif

""" key bind """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <C-U><C-B> :Unite buffer<CR>

""" command """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command XmlFormat :%!xmllint --format -
