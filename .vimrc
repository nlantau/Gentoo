" nlantau .vimrc, Gentoo
" Updated: 2021-06-27

" ----- Leader --------------------------------------------------------------
let mapleader=","
let maplocalleader=","
syntax on
filetype plugin indent on

" ----- Vim Plug ------------------------------------------------------------
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
"Plug 'dkasak/gruvbox'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neovimhaskell/haskell-vim'
Plug 'mboughaba/i3config.vim'
call plug#end()


" ----- Gruvbox -------------------------------------------------------------
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'hard'
set background=dark


" ----- Color ---------------------------------------------------------------
function! MyHighlights() abort
   highlight Visual ctermbg=white ctermfg=red 
endfunction

augroup MyColors
 autocmd!
 autocmd ColorScheme gruvbox call MyHighlights()
 autocmd InsertLeave * set cursorline
 autocmd InsertEnter * set nocursorline
augroup END

colorscheme gruvbox

" ----- Airline -------------------------------------------------------------
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" ----- au Vim --------------------------------------------------------------
augroup myVim
  au!
  au FileType vim setlocal expandtab
  au FileType vim setlocal tabstop=8
  au FileType vim setlocal shiftwidth=2
  au FileType vimrc setlocal shiftwidth=2
  au FileType vim setlocal softtabstop=2
  au FileType vimrc setlocal softtabstop=2
augroup END

" ----- au Make -------------------------------------------------------------
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

" ----- Markdown ------------------------------------------------------------
augroup myMD
  au!
  au FileType md setlocal expandtab
  au FileType md setlocal tabstop=8
  au FileType md setlocal shiftwidth=2
  au FileType md setlocal softtabstop=2
augroup END

" ----- au sh ---------------------------------------------------------------
augroup mySh
  au!
  au FileType sh setlocal expandtab
  au FileType sh setlocal tabstop=8
  au FileType sh setlocal shiftwidth=2
  au FileType sh setlocal softtabstop=2
augroup END

" ----- C -------------------------------------------------------------------
augroup myC
  au!
  au BufRead,BufNewFile *.c setfiletype c
  au FileType c setlocal expandtab
  au FileType c setlocal tabstop=8
  au FileType c setlocal shiftwidth=2
  au FileType c setlocal softtabstop=2
augroup END

" ----- Haskell -------------------------------------------------------------
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
let g:haskell_classic_highlighting = 1

" ----- au python -----------------------------------------------------------
augroup myPython
  au!
  au FileType python setlocal expandtab
  au FileType python setlocal tabstop=8
  au FileType python setlocal shiftwidth=4
  au FileType python setlocal softtabstop=4
augroup END

" ----- .vimrc --------------------------------------------------------------
autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
nnoremap <Leader>vv :vsplit $MYVIMRC<CR>

nnoremap ' `
inoremap jk <ESC>
tnoremap <Esc> <C-\><C-n>
nnoremap <Leader><ESC> :noh<CR><ESC>

" ----- Save And Close ------------------------------------------------
nnoremap <Leader><Leader> :w<CR>

" ----- Save And Compile pdf  -----------------------------------------
nnoremap <C-r>r :w<CR>:!pandoc -V geometry:margin=0.1in -o %:r.pdf %<Enter><CR>
nnoremap <C-r>l :w<CR>:!pdflatex %<Enter><CR>

" ----- Navigation ----------------------------------------------------
nnoremap <S-j> 10j<CR>
vnoremap <S-j> 10j<CR>
nnoremap <S-k> 10k<CR>
vnoremap <S-k> 10k<CR>

" ----- Editor Config -------------------------------------------------
set encoding=UTF-8
set clipboard=unnamed

" Vim fuzzy
set path+=**

" Searching
set hlsearch
set smartcase
set incsearch
set ignorecase

" General
set so=7
set nowrap
set number
set hidden
set wildmenu
set showmatch
set autoindent
set cursorline
set showbreak=↪
"set wrapmargin=8
set relativenumber

" Tab control
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab

set shiftround
set ruler
set showcmd
set nobackup
set splitright
set splitbelow
set noswapfile
set nobackup
set cmdheight=1
set laststatus=2
set nowritebackup
set updatetime=100


