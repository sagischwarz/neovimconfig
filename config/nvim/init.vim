call plug#begin('~/.local/share/nvim/plugged')
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'dense-analysis/ale'
Plug 'neomake/neomake'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'tpope/vim-fugitive'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-sleuth'
Plug 'Chiel92/vim-autoformat'
Plug 'alvan/vim-closetag'
Plug 'airblade/vim-rooter'
Plug 'wlangstroth/vim-racket'
Plug 'lervag/vimtex'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'leissa/vim-acme'

call plug#end()

" Misc
set number
set nowrap
set textwidth=0 wrapmargin=0
set guioptions+=b
set cursorline
set mouse=a "Enable mouse in terminal
set shell=zsh
set scrolloff=3
syntax on
set synmaxcol=250
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
set clipboard=unnamedplus

if (has("termguicolors"))
  set termguicolors
endif

colorscheme dracula

" Folding
set foldmethod=syntax
au BufRead * normal zR

" Airline settings
let g:airline_detect_paste=1 "Show PASTE if in paste mode
let g:airline#extensions#tabline#enabled = 1 "Show airline for tabs too
set laststatus=2 "Always dispay airline status bar

" Key bindings
nmap qb :bp\|bd #<CR>
map <c-i> :bn<CR>

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

" Latex settings
au BufNewFile,BufRead *.tex set spell spelllang=en_us wrap linebreak
set grepprg=grep\ -nH\ $*

let g:tex_flavor='latex'

let Tex_FoldedSections=""
let Tex_FoldedEnvironments=""
let Tex_FoldedMisc=""

" fzf
nmap <C-p> :Files<CR>
nmap <C-c> :Command<CR>
nmap <Leader>t :Tags<CR>
nmap ; :Buffers<CR>

" ack.vim
let g:ackprg = 'ag --vimgrep'
cnoreabbrev Ack Ack!
nnoremap <Leader>s :Ack! <cword><CR>
nnoremap <Leader>a :Ack!<Space>

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

" vim-polyglot
let g:polyglot_disabled = ['latex', 'csv']

" omnicompletion
"set omnifunc=syntaxcomplete#Complete
"set completeopt=longest,menuone
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Deoplete
let g:deoplete#enable_at_startup = 1
autocmd FileType markdown,text call deoplete#custom#buffer_option('auto_complete', v:false)
call deoplete#custom#option('auto_complete_delay', 0)
call deoplete#custom#option('sources', {'_': ['ale',],})
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" ale
let g:ale_completion_tsserver_autoimport = 1
let g:ale_linters = {'rust': ['rls'], 'python': ['pyls', 'mypy']}
let g:ale_linters_ignore = {'typescript': ['tslint'], 'html': ['tidy']}
let g:ale_fixers = {'python': ['black'], 'rust': ['rustfmt']}

let g:ale_html_htmlhint_options = '--rules attr-no-duplication,csslint,space-tab-mixed-disabled,tag-pair'
let g:ale_python_pyls_config = {'pyls': {'plugins': {'pycodestyle': {'enabled': v:false}}}}
let g:ale_python_black_options = '-l 120'
let g:ale_rust_rls_config = {'rust': {'clippy_preference': 'on'}}

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

map <F1> :ALEHover<CR>
map <F2> :ALERename<CR>
map <F3> :ALEFindReferences<CR>
map <F11> :ALEFix<CR>
nnoremap <silent> gd :ALEGoToDefinition<CR>

" autoformat
map <F12> :Autoformat<CR>
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
let g:formatters_python = ['black']
