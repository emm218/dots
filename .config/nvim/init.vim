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
" File Type Specific Stuff
" -----------------------------------------------------------------------------

autocmd FileType c setlocal equalprg=clang-format shiftwidth=8 tabstop=8 noexpandtab
autocmd FileType rust setlocal equalprg=rustfmt
autocmd FileType markdown setlocal textwidth=80 wrapmargin=0 formatoptions+=t linebreak

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
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'rust-lang/rust.vim'
Plug 'preservim/tagbar'

call plug#end()

syntax enable
filetype plugin indent on
let g:rustfmt_autosave = 1

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
let g:Hexokinase_ftEnabled = ['css', 'html', 'javascript']

lua require("catppuccin").setup({
			\ transparent_background = true,
			\	color_overrides = { mocha = { 
			\		surface2 = "#b4befe",
			\		surface1 = "#b4befe",
			\	}}})

colorscheme catppuccin-mocha
" -----------------------------------------------------------------------------
" Keymaps
" -----------------------------------------------------------------------------

let mapleader="\<space>"

nmap <leader>F :AllFiles<cr>
nmap <leader>f :Files<cr>
nmap <leader>b :Buffers<cr>

nmap <leader>c :TagbarToggle<cr>

nnoremap <tab> <C-w>
" nnoremap <expr> <leader>n g:NERDTree.IsOpen() ? 
"			\ ':NERDTreeClose<CR>' : @% == '' ? 
"			\ ':NERDTree<CR>' : ':NERDTreeFind<CR>'
