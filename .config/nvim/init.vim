" -----------------------------------------------------------------------------
" General Settings
" -----------------------------------------------------------------------------

set relativenumber
set number
set scrolloff=8
set hidden
set clipboard=unnamedplus
set termguicolors

" -----------------------------------------------------------------------------
" Plugins
" -----------------------------------------------------------------------------

call plug#begin()

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

call plug#end()

let g:fzf_layout = {'up':'~90%',
		\ 'window': {
		\		'width':1.0,
		\		'height':0.2,
		\		'yoffset':1.0,
		\		'xoffset':0.0,
		\		'border':'sharp'
		\		}
		\ }

let $FZF_DEFAULT_OPTS = '--color=16,bg:black,fg:white,border:white,pointer:magenta,fg+:magenta --info=inline'

command! -bang -nargs=? -complete=dir Files
			\ call fzf#run(fzf#wrap('files', 
			\ {'dir': <q-args>, 
			\ 'sink':'e', 'source':'rg --files' 
			\ }, <bang>0))

command! -bang -nargs=? -complete=dir AllFiles
			\ call fzf#run(fzf#wrap('files', 
			\ {'dir': <q-args>, 
			\ 'sink':'e', 'source':'rg --files --hidden' 
			\ }, <bang>0))

let g:Hexokinase_highlighters = ['backgroundfull']

lua require("catppuccin").setup({transparent_background = true,})

colorscheme catppuccin-mocha
" -----------------------------------------------------------------------------
" Keymaps
" -----------------------------------------------------------------------------

let mapleader="\<space>"

nmap <leader>F :AllFiles<cr>
nmap <leader>f :Files<cr>
nmap <leader>b :Buffers<cr>

" nnoremap <expr> <leader>n g:NERDTree.IsOpen() ? 
"			\ ':NERDTreeClose<CR>' : @% == '' ? 
"			\ ':NERDTree<CR>' : ':NERDTreeFind<CR>'
