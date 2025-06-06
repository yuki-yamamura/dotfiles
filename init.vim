set clipboard+=unnamed
set encoding=utf-8
set number
set showcmd
set visualbell t_vb=
set path+=$PWD/**
let mapleader = "\<space>"
syntax on
set noshowmode
set laststatus=2

set autoindent
set expandtab 
set tabstop=2
set shiftwidth=2

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

" fzf.vim
nnoremap <leader>f :Files<CR>
nnoremap <leader>h :History<CR>
nnoremap <leader>r :Rg<CR>

" coc-nvim
nmap <silent> <space>h :<C-u>call CocAction('doHover')<cr>
nmap <silent> <space>gd <Plug>(coc-definition)
nmap <silent> <space>gr <Plug>(coc-references)
nmap <silent> <space>r <Plug>(coc-rename)
nmap <silent> <space>fmt <Plug>(coc-format)

call plug#begin(expand('~/.vim/plugged'))
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'https://github.com/adelarsq/vim-matchit'
Plug 'rhysd/vim-gfm-syntax'
Plug 'https://tpope.io/vim/surround.git'
Plug 'https://tpope/vim-repeat.git'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'cohama/lexima.vim'
call plug#end()

autocmd VimEnter * highlight Normal ctermbg=NONE guibg=NONE
colorscheme catppuccin-frappe
let g:lightline = {'colorscheme': 'catppuccin'}

