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
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
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
  au FileType c setlocal shiftwidth=2
  au FileType c setlocal tabstop=2
  au FileType c setlocal noexpandtab
  au FileType c setlocal listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
  au FileType c setlocal list
augroup END

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

inoremap jk <ESC>
tnoremap <Esc> <C-\><C-n>
nnoremap <Leader><ESC> :noh<CR><ESC>

" ----- Save And Close ------------------------------------------------
nnoremap <Leader><Leader> :w<CR>

" ----- Save And Compile pdf  -----------------------------------------
nnoremap <C-r>l :w<CR>:!pdflatex %<Enter><CR>

" ----- Navigation ----------------------------------------------------
nnoremap <S-j> 10j<CR>
vnoremap <S-j> 10j<CR>
nnoremap <S-k> 10k<CR>
vnoremap <S-k> 10k<CR>

" ----- Editor Config -------------------------------------------------
set encoding=UTF-8
set clipboard=unnamedplus

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
set relativenumber

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


