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
set foldmethod=syntax
au BufRead * normal zR

" Key bindings
nmap qb :bp\|bd #<CR>
nmap <C-w>b :bp\|bd #<CR>

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
nmap <Leader>n :NERDTreeToggle<CR>

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

" omnicompletion
" set omnifunc=syntaxcomplete#Complete
" set completeopt=longest,menuone
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" LSP
lua <<EOF
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>D', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<F1>', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<F3>', '<cmd>lua vim.lsp.buf.references({ includeDeclaration = false })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<F12>', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end


-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'vuels' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    debounce_text_changes = 150,
  }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
    { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
EOF

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
