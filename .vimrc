" base
set clipboard+=unnamed
set encoding=utf-8
set number
set showcmd
set visualbell t_vb=
set path+=$PWD/**
let mapleader = "\<space>"
syntax on

" indents
set autoindent
set expandtab 
set shiftwidth=2
set tabstop=2

" search
set hlsearch
set ignorecase
set incsearch
set smartcase

" key mappings
inoremap <C-d> <Del>
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap H Hzz
nnoremap L Lzz
nnoremap s "_s
nnoremap x "_x
nnoremap <leader>s s
nnoremap <leader>J J
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

map J :tabprev<Return>
map K :tabnext<Return>
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w
nmap sh <C-w>h
nmap sk <C-w>k
nmap sj <C-w>j
nmap sl <C-w>l

" lightline.vim
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ }

" vim-plug
call plug#begin(expand('~/.vim/plugged'))
Plug 'arcticicestudio/nord-vim', { 'tag': 'v0.11.0' }
Plug 'https://github.com/adelarsq/vim-matchit'
Plug 'rhysd/vim-gfm-syntax'
Plug 'https://tpope.io/vim/surround.git'
Plug 'itchyny/lightline.vim'
call plug#end()

" theme
colorscheme nord
