call plug#begin('~/.local/share/nvim/plugged')
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh'}
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
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'tpope/vim-fugitive'
Plug 'luochen1990/rainbow'
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

autocmd BufEnter * silent! lcd %:p:h

if has("gui_running")
    set lines=35 columns=130
endif
set clipboard=unnamedplus

if (has("termguicolors"))
  set termguicolors
endif

colorscheme onedark

" Airline settings
let g:airline_detect_paste=1 "Show PASTE if in paste mode
let g:airline#extensions#tabline#enabled = 1 "Show airline for tabs too
set laststatus=2 "Always dispay airline status bar

" Key bindings
nmap <F12> :%!jq '.'<cr>
nmap <F11> :%s/\r\(\n\)/\1/g<cr>
nmap <F10> :%s/\n//g<cr>

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
command Texmode set spell spelllang=en_us wrap linebreak
set grepprg=grep\ -nH\ $*

let g:tex_flavor='latex'

let Tex_FoldedSections=""
let Tex_FoldedEnvironments=""
let Tex_FoldedMisc=""

" fzf
nmap <C-p> :Files<CR>
nmap <Leader>t :Tags<CR>
nmap ; :Buffers<CR>

" ack.vim
let g:ackprg = 'ag --vimgrep'
cnoreabbrev Ack Ack!
nnoremap <Leader>s :Ack! <cword><CR>
nnoremap <Leader>a :Ack!<Space>

" Markdown
let g:vim_markdown_folding_disabled=0

" Nerdtree settings
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeShowHidden=1
nmap <Leader>n :NERDTreeFocus<cr>

" Kernel mode
command Kernelmode set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab

" Gitgutter
let g:gitgutter_diff_args = '-w'

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

" Rainbow
let g:rainbow_active = 1

" vim-rooter
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_silent_chdir = 1

" vim-polyglot
let g:polyglot_disabled = ['latex']

" omnicompletion
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('auto_complete_delay', 200)

" Language server
let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ 'c': ['clangd'],
    \ 'cpp': ['clangd'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
