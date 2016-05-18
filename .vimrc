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
set background=dark

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

"" Time out on key codes but not mappings (makes terminal Vim work sanely)
set notimeout
set ttimeout
set ttimeoutlen=100

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

" Remove highlighted search results
nnoremap <C-L> :nohlsearch<CR><C-L>

"" Remove trailing whitespace on save
function! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

"" Vundle {
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()
Plugin 'VundleVim/Vundle.vim'
filetype plugin indent on

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'itchyny/lightline.vim'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-haml'
Plugin 'elixir-lang/vim-elixir'
Plugin 'lambdatoast/elm.vim.git'
Plugin 'dejan/oceanic-next'
" https://github.com/gmarik/vundle/issues/176#issuecomment-12996269
filetype off
filetype plugin indent on
"" }

" Theme
set t_Co=256
set background=dark
colorscheme OceanicNext " requires: https://github.com/mhartington/oceanic-next-iterm

"" Show syntax highlighting groups for word under cursor (useful for tweaking colorscheme)
nmap <C-S-I> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

"" CtrlP config
let g:ctrlp_map = '<c-p>'
let g:ctrlp_max_height = 10           " maxiumum height of match window
let g:ctrlp_switch_buffer = 'et'      " jump to a file if it's open already
let g:ctrlp_use_caching = 1           " enable caching
let g:ctrlp_clear_cache_on_exit=0     " speed up by not removing clearing cache evertime
let g:ctrlp_show_hidden = 1           " show me dotfiles
let g:ctrlp_mruf_max = 250            " number of recently opened files
set wildignore+=*/tmp/*,*/log/*,*/var/*,*.so,*.swp,*.log,*.class,*/target/*,*/_build/*,*/node_modules/*,*/deps/*  " exclude files and directories using Vim's wildignore
let g:ctrlp_buftag_types = {
\ 'go'     	   : '--language-force=go --golang-types=ftv',
\ 'coffee'     : '--language-force=coffee --coffee-types=cmfvf',
\ 'markdown'   : '--language-force=markdown --markdown-types=hik',
\ 'objc'       : '--language-force=objc --objc-types=mpci',
\ 'rc'         : '--language-force=rust --rust-types=fTm'
\ }
