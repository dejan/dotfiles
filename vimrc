"" General
set exrc                    " load vimrc from current directory
set nocompatible            " vim only

"" Display
color twilight              " color scheme
syntax enable               " syntax highlight
set synmaxcol=800           " don't try to highlight long lines
set guifont=Monaco:h12      " font
set number                  " show line number
set showmode                " display the current mode
set showcmd                 " display partially-typed commands in the status line

"" Clipboard
set clipboard+=unnamed      " yanks go to clipboard

"" Buffers & files
set encoding=utf-8          " encoding
set updatecount=0           " Disable swap files
set autoread                " Auto-reload buffers when file changed on disk
set hidden                  " Allow backgrounding buffers without writing them

"" Formating
set nowrap                       " don't wrap lines
set tabstop=2                    " a tab is two spaces
set shiftwidth=2                 " an autoindent (with <<) is two spaces
set expandtab                    " use spaces, not tabs
set backspace=indent,eol,start   " backspace through everything in insert mode

"" Searching
set hlsearch                     " highlight matches
set incsearch                    " incremental searching
set ignorecase                   " searches are case insensitive...
set smartcase                    " ... unless they contain at least one capital letter
set gdefault                     " have :s///g flag by default on
nnoremap <cr> :nohlsearch<cr>    " Clear the search buffer when hitting return

"" Time out on key codes but not mappings (makes terminal Vim work sanely)
set notimeout
set ttimeout
set ttimeoutlen=100

" Indent lines with cmd+[ and cmd+]
nmap <D-]> >>
nmap <D-[> <<
vmap <D-[> <gv
vmap <D-]> >gv

"" Vundle
filetype off                
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
filetype plugin indent on

Bundle "tpope/vim-rails.git"
Bundle "kchmck/vim-coffee-script"
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/vim-snippets"
Bundle "garbas/vim-snipmate"
Bundle "tomtom/tcomment_vim"
Bundle "spolu/dwm.vim"

" TComment config
map <D-/> :TComment<cr>
vmap <D-/> :TComment<cr>gv

"" CtrlP config
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<D-t>'
let g:ctrlp_cmd = 'CtrlPMixed'			" search anything (in files, buffers and MRU files at the same time.)
let g:ctrlp_working_path_mode = 'ra'	" search for nearest ancestor like .git, .hg, and the directory of the current file
let g:ctrlp_match_window_bottom = 0		" show the match window at the top of the screen
let g:ctrlp_max_height = 10				" maxiumum height of match window
let g:ctrlp_switch_buffer = 'et'		" jump to a file if it's open already
let g:ctrlp_use_caching = 1				" enable caching
let g:ctrlp_clear_cache_on_exit=0  		" speed up by not removing clearing cache evertime
let g:ctrlp_show_hidden = 1				" show me dotfiles
let g:ctrlp_mruf_max = 250 				" number of recently opened files

" TODO: add javascript and some other languages who doesn't have ctags support
" coffee: https://gist.github.com/michaelglass/5210282
" go: http://stackoverflow.com/a/8236826/462233 
" objc:  http://www.gregsexton.org/2011/04/objective-c-exuberant-ctags-regex/
" rust: https://github.com/mozilla/rust/blob/master/src/etc/ctags.rust
let g:ctrlp_buftag_types = {
\ 'go'     	   : '--language-force=go --golang-types=ftv',
\ 'coffee'     : '--language-force=coffee --coffee-types=cmfvf',
\ 'markdown'   : '--language-force=markdown --markdown-types=hik',
\ 'objc'       : '--language-force=objc --objc-types=mpci',
\ 'rc'         : '--language-force=rust --rust-types=fTm'
\ }

" Open goto symbol on current buffer
nmap <D-r> :MyCtrlPTag<cr>
imap <D-r> <esc>:MyCtrlPTag<cr>

" Open goto symbol on all buffers
nmap <D-R> :CtrlPBufTagAll<cr>
imap <D-R> <esc>:CtrlPBufTagAll<cr>

" Open goto file
nmap <D-t> :CtrlP<cr>
imap <D-t> <esc>:CtrlP<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

