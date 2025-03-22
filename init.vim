set clipboard+=unnamed
set encoding=utf-8
set number
set showcmd
set visualbell t_vb=
set path+=$PWD/**
let mapleader = "\<space>"
syntax on
set noshowmode

set autoindent
set expandtab 

set hlsearch
set ignorecase
set incsearch
set smartcase

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

set laststatus=2
call plug#begin(expand('~/.vim/plugged'))
Plug 'https://github.com/adelarsq/vim-matchit'
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'rhysd/vim-gfm-syntax'
Plug 'https://tpope.io/vim/surround.git'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'cohama/lexima.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

let g:lightline = {'colorscheme': 'catppuccin'}
colorscheme catppuccin-frappe

vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)
