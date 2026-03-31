" vim-polyglot: Needs to be done before loading the plugin
let g:polyglot_disabled = ['latex', 'csv']

lua << EOF
vim.pack.add({
  -- LSP and autocompletion
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/hrsh7th/cmp-nvim-lsp',
  'https://github.com/hrsh7th/cmp-buffer',
  'https://github.com/hrsh7th/cmp-path',
  'https://github.com/hrsh7th/cmp-cmdline',
  'https://github.com/hrsh7th/nvim-cmp',
  'https://github.com/L3MON4D3/LuaSnip',
  'https://github.com/saadparwaiz1/cmp_luasnip',

  -- Navigation and search
  'https://github.com/junegunn/fzf',
  'https://github.com/junegunn/fzf.vim',
  'https://github.com/scrooloose/nerdtree',

  -- UI
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/arcticicestudio/nord-vim',
  'https://github.com/arzg/vim-colors-xcode',
  'https://github.com/rakr/vim-one',
  'https://github.com/f-person/auto-dark-mode.nvim',

  -- Git
  'https://github.com/airblade/vim-gitgutter',
  'https://github.com/tpope/vim-fugitive',

  -- Editing
  'https://github.com/godlygeek/tabular',
  'https://github.com/easymotion/vim-easymotion',
  'https://github.com/terryma/vim-multiple-cursors',
  'https://github.com/tpope/vim-surround',
  'https://github.com/tpope/vim-repeat',
  'https://github.com/tpope/vim-unimpaired',
  'https://github.com/scrooloose/nerdcommenter',
  'https://github.com/RRethy/vim-illuminate',

  -- Language and filetype support
  'https://github.com/sheerun/vim-polyglot',
  'https://github.com/plasticboy/vim-markdown',
  'https://github.com/lervag/vimtex',
  'https://github.com/leissa/vim-acme',
  'https://github.com/alvan/vim-closetag',

  -- Utility
  'https://github.com/neomake/neomake',
  'https://github.com/tpope/vim-eunuch',
  'https://github.com/tpope/vim-sleuth',
  'https://github.com/Chiel92/vim-autoformat',
  'https://github.com/airblade/vim-rooter',
  'https://github.com/mbbill/undotree',
  'https://github.com/voldikss/vim-floaterm',
  'https://github.com/folke/todo-comments.nvim',

  -- Distraction-free writing
  'https://github.com/junegunn/goyo.vim',
  'https://github.com/junegunn/limelight.vim',

  -- Debugging
  'https://github.com/puremourning/vimspector',
})
EOF

" Misc
let mapleader = "\<Space>"
set number
set nowrap
set textwidth=0 wrapmargin=0
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

set guifont=Fira\ Code:h14
set clipboard=unnamedplus

"if (has("termguicolors"))
"  set termguicolors
"endif

"colorscheme xcodelight

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
nmap <Leader>s :Rg <C-R><C-W><CR>
nmap <Leader>a :Rg <CR>
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

