if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-polyglot: Needs to be done before loading the plugin
let g:polyglot_disabled = ['latex', 'csv']

call plug#begin('~/.local/share/nvim/plugged')
Plug 'neovim/nvim-lspconfig' "LSP base
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'neomake/neomake' " Async run programs
Plug 'junegunn/fzf' " Fuzzy search
Plug 'junegunn/fzf.vim' " Fuzzy search
Plug 'scrooloose/nerdtree' " File tree
Plug 'vim-airline/vim-airline' " Status line
Plug 'vim-airline/vim-airline-themes' " Status line themes
Plug 'airblade/vim-gitgutter' " Git hints in gutter
Plug 'godlygeek/tabular' " Text aligning
Plug 'plasticboy/vim-markdown' " Markdown support
Plug 'easymotion/vim-easymotion' " Quickly move to text with two characters
Plug 'terryma/vim-multiple-cursors' " Multi cursor support
Plug 'arcticicestudio/nord-vim' " Nord theme
Plug 'sheerun/vim-polyglot' " Syntax and indentation for many languages
Plug 'junegunn/goyo.vim' " Distraction free writing
Plug 'junegunn/limelight.vim' " Highlight current text block
Plug 'tpope/vim-fugitive' " Git client
Plug 'tpope/vim-eunuch' " Additional commands
Plug 'tpope/vim-surround' " Surround with characters
Plug 'tpope/vim-repeat' " Improved . repeating for commands
Plug 'tpope/vim-unimpaired' " [-mappings
Plug 'scrooloose/nerdcommenter' " Improved comment handling
Plug 'tpope/vim-sleuth' " Heuristically set buffer options 
Plug 'Chiel92/vim-autoformat' " Autoformat files
Plug 'alvan/vim-closetag' " Close HTML tags
Plug 'airblade/vim-rooter' " Change working directory
Plug 'lervag/vimtex' " LaTeX support
Plug 'leissa/vim-acme' " 6502-family assembler
Plug 'mbbill/undotree' " Undo tree
Plug 'puremourning/vimspector' " Debugger
Plug 'voldikss/vim-floaterm' " Floating terminal
Plug 'RRethy/vim-illuminate' " Highlight word under cursor
Plug 'nvim-lua/plenary.nvim' " Dependency for other plugins
Plug 'jose-elias-alvarez/null-ls.nvim' " LSP wrapper for formatters
Plug 'folke/todo-comments.nvim' " List TODOs from comments

call plug#end()

" Misc
let mapleader = "\<Space>"
set number
set nowrap
set textwidth=0 wrapmargin=0
set guioptions+=b
set cursorline
set mouse=a " Enable mouse in terminal
set shell=zsh
set scrolloff=3
syntax on
set synmaxcol=320
set undofile
set splitbelow
set splitright
set hidden

set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4

set nobackup
set nowritebackup

set ic
set nohlsearch

set wildmenu
set wildmode=list:longest,full

set exrc

autocmd BufEnter * silent! lcd %:p:h

if has("gui_running")
    set lines=35 columns=130
endif

set guifont=Fira\ Code:h10
set clipboard=unnamedplus

if (has("termguicolors"))
  set termguicolors
endif

colorscheme nord

" Folding
set nofoldenable

" Window management
nmap <C-w>- :split<CR>
nmap <C-w>\ :vsplit<CR>

" Misc key bindings
nmap qb :bp\|bd #<CR>
nmap <C-w>b :bp\|bd #<CR>
nmap <Leader>fw :silent execute "!firefox 'https://google.com/search?q=<cword>'"<CR>

" HTML settings
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

" Filetype aliases
au BufNewFile,BufRead *.ino set filetype=c
au BufNewFile,BufRead *.asm set filetype=nasm

augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
augroup END

command! -nargs=* Writemode set wrap linebreak nolist

" Airline settings
let g:airline_detect_paste=1 " Show PASTE if in paste mode
let g:airline#extensions#tabline#enabled = 1 " Show airline for tabs too
set laststatus=2 " Always dispay airline status bar

" Latex settings
au BufNewFile,BufRead *.tex set spell spelllang=en_us wrap linebreak
set grepprg=grep\ -nH\ $*

let g:tex_flavor='latex'

let Tex_FoldedSections=""
let Tex_FoldedEnvironments=""
let Tex_FoldedMisc=""

" fzf
nmap <C-p> :execute 'Files '.FindRootDirectory()<CR>
nmap <C-c> :Command<CR>
nmap <Leader>t :Tags<CR>
nmap ; :Buffers<CR>
nmap <Leader>s :Ag <C-R><C-W><CR>
nmap <Leader>a :Ag <CR>
nmap <A-S-r> :History<CR>
nmap <C-h> :BCommits<CR>
nmap <A-h> :Commits<CR>

" Markdown
let g:vim_markdown_folding_disabled=0
au BufNewFile,BufRead *.md,*.MD set wrap linebreak

" Nerdtree settings
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeShowHidden = 1
nmap <Leader>n :NERDTreeFocus<CR>

" Kernel mode
command Kernelmode set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab

" Gitgutter
set updatetime=250

" EasyMotion
let g:EasyMotion_do_mapping = 0
nmap s <Plug>(easymotion-overwin-f2)
let g:EasyMotion_smartcase = 1
nmap <Leader>j <Plug>(easymotion-j)
nmap <Leader>k <Plug>(easymotion-k)

" Matchit
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" Goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
let g:goyo_width = 120

" vim-rooter
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_silent_chdir = 1

" autoformat
map <F12> :Autoformat<CR>
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
let g:formatters_python = ['black']

" undotree
nmap <A-u> :UndotreeToggle<CR>

" Vimspector
nmap <Leader>di <Plug>VimspectorBalloonEval
xmap <Leader>di <Plug>VimspectorBalloonEval
nmap <Leader>da :VimspectorReset<CR>
xmap <Leader>da :VimspectorReset<CR>
nmap <F5> <Plug>VimspectorContinue
nmap <F6> <Plug>VimspectorPause
nmap <F7> <Plug>VimspectorStop
nmap <F8> <Plug>VimspectorJumpToNextBreakpoint
nmap <F9> <Plug>VimspectorToggleBreakpoint
nmap <F10> <Plug>VimspectorStepOver
nmap <F11> <Plug>VimspectorStepInto
let g:vimspector_sign_priority = {
  \    'vimspectorBP':         400,
  \    'vimspectorBPCond':     300,
  \    'vimspectorBPLog':      200,
  \    'vimspectorBPDisabled': 100,
  \    'vimspectorPC':         999,
  \ }

" unimpaired (missing mappings)
nmap [t :tabprevious<CR>
nmap ]t :tabnext<CR>

" Floaterm bindings
let g:floaterm_height = 0.9
let g:floaterm_width = 0.9
let g:floaterm_keymap_toggle = '<Leader>tt'
let g:floaterm_keymap_prev = '<Leader>tp'
let g:floaterm_keymap_next = '<Leader>tn'
let g:floaterm_keymap_kill = '<Leader>tk'
nmap <Leader>tg :FloatermNew lazygit<CR>

