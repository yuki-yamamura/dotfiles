" base
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

" indents
set autoindent
set expandtab 
set tabstop=2
set shiftwidth=2

" search
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
nnoremap <leader>y :let @*=expand("%:p")<CR>:echo "Copied: " . expand("%:p")<CR>
nnoremap <C--> <C-o>

map J :tabprev<Return>
map K :tabnext<Return>
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w
nmap sh <C-w>h
nmap sk <C-w>k
nmap sj <C-w>j
nmap sl <C-w>l

" coc-nvim
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-css',
  \ 'coc-json',
  \ 'coc-html',
  \ 'coc-spell-checker',
  \ 'coc-prettier',
  \ 'coc-go',
  \ ]

nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>r <Plug>(coc-rename)
nmap <silent> <leader>aw :CocCommand cSpell.addWordToUserDictionary<CR>
nmap <silent> <leader>. <Plug>(coc-codeaction-cursor)
nmap <silent> <leader>h <Plug>(coc-diagnostic-info)
nmap <silent> <leader>c :!code %<CR>

call plug#begin(expand('~/.vim/plugged'))
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'https://github.com/adelarsq/vim-matchit'
Plug 'rhysd/vim-gfm-syntax'
Plug 'https://tpope.io/vim/surround.git'
Plug 'tpope/vim-repeat'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'folke/flash.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'akinsho/toggleterm.nvim', {'tag' : 'v2*'}
Plug 'sindrets/diffview.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'mikavilpas/yazi.nvim'
call plug#end()

autocmd VimEnter * highlight Normal ctermbg=NONE guibg=NONE
autocmd VimEnter * highlight NormalNC ctermbg=NONE guibg=NONE

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

lua require("catppuccin").setup({ dim_inactive = { enabled = false } })
colorscheme catppuccin-frappe
let g:lightline = {'colorscheme': 'catppuccin'}

highlight @markup.raw guifg=#c6d0f5
highlight @markup.raw.block guifg=#c6d0f5

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "markdown",
    "markdown_inline",
    "go",
    "typescript",
    "javascript",
    "bash",
    "html",
    "yaml",
    "json",
    "tsx",
    "sql",
    "scala",
    "hcl",
    "css",
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

require("flash").setup({
  modes = {
    search = {
      enabled = true,
      highlight = { backdrop = true },
      jump = { history = true, register = true, nohlsearch = true },
    },
    char = {
      enabled = false,
    },
  },
})

require("ibl").setup({
  scope = { enabled = false },
})

require("toggleterm").setup()

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  direction = "float",
  hidden = true
})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})

local lazydocker = Terminal:new({
  cmd = "lazydocker",
  direction = "float",
  hidden = true
})

function _lazydocker_toggle()
  lazydocker:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>d", "<cmd>lua _lazydocker_toggle()<CR>", {noremap = true, silent = true})

require("yazi").setup({
  open_for_directories = false,
})

vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>Yazi<CR>", {noremap = true, silent = true})
EOF
