" -----------------------------------------------------------------------------
" General Settings
" -----------------------------------------------------------------------------

set relativenumber
set number
set scrolloff=8
set hidden
set clipboard=unnamedplus
set termguicolors
set modeline

function! Preserve(command)
	let search = @/
	let cursor_position = getpos('.')
	normal! H
	let window_position = getpos('.')
	call setpos('.', cursor_position)

	execute a:command

	let @/ = search
	call setpos('.', window_position)
	normal! zt
	call setpos('.', cursor_position)
endfunction

set statusline=%f\ %h%w%m%r
set statusline+=%{FugitiveStatusline()}
set statusline+=%=
set statusline+=%-14.(%l,%c%V%)\ %P

" -----------------------------------------------------------------------------
" File Type Specific Stuff
" -----------------------------------------------------------------------------
let g:c_syntax_for_h = 1

autocmd FileType c setlocal equalprg=clang-format shiftwidth=8 tabstop=8 signcolumn=yes noexpandtab 
autocmd FileType c autocmd BufWritePre <buffer> call Preserve('normal gg=G')
autocmd FileType rust setlocal equalprg=rustfmt signcolumn=yes
autocmd FileType markdown setlocal textwidth=80 wrapmargin=0 formatoptions+=t linebreak
autocmd TermOpen * setlocal nonumber norelativenumber

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
Plug 'Mofiqul/dracula.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'rust-lang/rust.vim'
Plug 'preservim/tagbar'
Plug 'ap/vim-buftabline'
Plug 'neovim/nvim-lspconfig'
Plug 'jessarcher/vim-heritage'
Plug 'shirk/vim-gas'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-orgmode/orgmode'

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
let g:tagbar_width = 60

lua require("lspconfig").rust_analyzer.setup({})
lua require("lspconfig").clangd.setup({})

lua require("catppuccin").setup({
			\ transparent_background = true,
			\ custom_highlights = function(colors)
			\ 	return {
			\     Comment    = { fg = colors.green },
			\			PMenuSel 	 = { fg = colors.green },
			\     TabLineSel = { fg = colors.green, bg = colors.none },
			\     TabLine    = { fg = colors.text,  bg = colors.none },
			\  	}
			\ end})

lua require("dracula").setup({transparent_bg = true, 
			\ overrides = function(colors) return {
			\		TabLineFill = { bg = colors.none },
			\		StatusLine  = { bg = colors.none },
			\	} end })

if ( $TERM == 'linux' )
  colorscheme default
else
	colorscheme dracula
endif

lua vim.diagnostic.config({virtual_text = false, update_in_insert = false})

set updatetime=250
" -----------------------------------------------------------------------------
" Keymaps
" -----------------------------------------------------------------------------

map gf :edit <cfile><cr>

let mapleader="\<space>"
nmap <leader>F :AllFiles<cr>
nmap <leader>f :Files<cr>
nmap <leader>q :bd!<cr>
nmap <leader>c :TagbarToggle<cr>
nnoremap <leader>t :term<cr> 
nnoremap <leader>g :Git<space>
nnoremap <leader>d <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <leader>r <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <leader>e <cmd>lua vim.diagnostic.open_float(nil, {focus=false})<cr>

nnoremap <M-tab> :bnext<cr>
nnoremap <M-S-tab> :bprev<cr>

nnoremap <tab> <C-w>
" nnoremap <expr> <leader>n g:NERDTree.IsOpen() ? 
"			\ ':NERDTreeClose<CR>' : @% == '' ? 
"			\ ':NERDTree<CR>' : ':NERDTreeFind<CR>'
