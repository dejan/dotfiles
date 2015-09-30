"" General
set exrc                    " load vimrc from current directory
set nocompatible            " vim only

"" History
set history=1000

"" Display
syntax enable               " syntax highlight
set synmaxcol=800           " don't try to highlight long lines
set guifont=Monaco:h13      " font
set number                  " show line number
set showmode                " display the current mode
set showcmd                 " display partially-typed commands in the status line
set laststatus=2            " neded for lightline.vim
set list                    " show whitespace

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
" <cr> to remove highlighted search results
" wrapping this in function prevents annoying 2-space jump
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()

"" Time out on key codes but not mappings (makes terminal Vim work sanely)
set notimeout
set ttimeout
set ttimeoutlen=100

"" Indent lines with cmd+[ and cmd+]
nmap <D-]> >>
nmap <D-[> <<
vmap <D-[> <gv
vmap <D-]> >gv
imap <D-]> <esc>>>
imap <D-[> <esc><<

"" Rename current file
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

"" Vundle
filetype off                
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()
Bundle 'gmarik/vundle'
filetype plugin indent on

Bundle "kien/ctrlp.vim"
Bundle "kchmck/vim-coffee-script"
Bundle "tomtom/tcomment_vim"
Bundle "flazz/vim-colorschemes"
Bundle "mileszs/ack.vim"
Bundle "tpope/vim-fugitive"
Bundle "scrooloose/syntastic"
Bundle "ervandew/supertab"
Bundle "itchyny/lightline.vim"
Bundle "janx/vim-rubytest"
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle "derekwyatt/vim-scala"
Bundle "vim-scripts/bufkill.vim"
Bundle "t9md/vim-ruby-xmpfilter"

"" Color scheme
color dracula

"" TComment config
map <D-/> :TComment<cr>
vmap <D-/> :TComment<cr>gv

"" Ack
nmap <D-F> :Ack<space>

"" CtrlP config
let g:ctrlp_map = '<D-t>'
let g:ctrlp_max_height = 10				    " maxiumum height of match window
let g:ctrlp_switch_buffer = 'et'		  " jump to a file if it's open already
let g:ctrlp_use_caching = 1				    " enable caching
let g:ctrlp_clear_cache_on_exit=0  		" speed up by not removing clearing cache evertime
let g:ctrlp_show_hidden = 1				    " show me dotfiles
let g:ctrlp_mruf_max = 250 				    " number of recently opened files
set wildignore+=*/tmp/*,*/log/*,*/var/*,*.so,*.swp,*.log,*.class,*/target/*  " exclude files and directories using Vim's wildignore

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

" https://github.com/gmarik/vundle/issues/176#issuecomment-12996269
filetype off
filetype plugin indent on

"" configure vim-rubytest 
let g:rubytest_in_quickfix = 1                                              " test output in quickfix window
let g:rubytest_cmd_test = "spring rake test %p"                             " 'spring' is the fastest, compared to 'bundle exec' or 'bin/spring'
let g:rubytest_cmd_testcase = "spring rake test %p TESTOPTS=\"-n '/%c/'\""  " same here
" map key bindings
map <Leader>Y <Plug>RubyTestRun
map <Leader>t <Plug>RubyFileRun

" markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['coffee', 'css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml', 'html', 'sql']

" xmpfilter (rcodetools)
" https://coderwall.com/p/3vtqwq/evaluate-ruby-in-vim
nmap <buffer> <D-E> <Plug>(xmpfilter-run)
xmap <buffer> <D-E> <Plug>(xmpfilter-run)
imap <buffer> <D-E> <Plug>(xmpfilter-run)
nmap <buffer> <D-e> <Plug>(xmpfilter-mark)
xmap <buffer> <D-e> <Plug>(xmpfilter-mark)
imap <buffer> <D-e> <Plug>(xmpfilter-mark)
