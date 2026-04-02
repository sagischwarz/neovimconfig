-- vim-polyglot: Needs to be done before loading the plugin
vim.g.polyglot_disabled = { 'latex', 'csv' }

vim.pack.add({
  -- LSP and autocompletion
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/saghen/blink.cmp',
  'https://github.com/folke/lazydev.nvim',

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

-- Misc
vim.g.mapleader = ' '
vim.opt.number = true
vim.opt.wrap = false
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0
vim.opt.cursorline = true
vim.opt.mouse = 'a'
vim.opt.shell = 'zsh'
vim.opt.scrolloff = 3
vim.opt.synmaxcol = 320
vim.opt.undofile = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.hidden = true

vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.backup = false
vim.opt.writebackup = false

vim.opt.ignorecase = true
vim.opt.hlsearch = false

vim.opt.wildmenu = true
vim.opt.wildmode = 'list:longest,full'

vim.opt.exrc = true

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  command = 'silent! lcd %:p:h',
})

if vim.fn.has('gui_running') == 1 then
  vim.opt.lines = 35
  vim.opt.columns = 130
end

vim.opt.guifont = 'Fira Code:h14'
vim.opt.clipboard = 'unnamedplus'

-- Folding
vim.opt.foldenable = false

-- Window management
vim.keymap.set('n', '<C-w>-', '<cmd>split<CR>')
vim.keymap.set('n', '<C-w>\\', '<cmd>vsplit<CR>')

-- Misc key bindings
vim.keymap.set('n', 'qb', '<cmd>bp|bd #<CR>')
vim.keymap.set('n', '<C-w>b', '<cmd>bp|bd #<CR>')
vim.keymap.set('n', '<Leader>fw', function()
  vim.cmd("silent !firefox 'https://google.com/search?q=" .. vim.fn.expand('<cword>') .. "'")
end)

-- HTML settings
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'html',
  callback = function()
    vim.bo.omnifunc = 'htmlcomplete#CompleteTags'
  end,
})

-- Filetype aliases
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.ino',
  callback = function() vim.bo.filetype = 'c' end,
})
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.asm',
  callback = function() vim.bo.filetype = 'nasm' end,
})

-- Cursorline only in active window
local bg_highlight = vim.api.nvim_create_augroup('BgHighlight', { clear = true })
vim.api.nvim_create_autocmd('WinEnter', {
  group = bg_highlight,
  pattern = '*',
  callback = function() vim.opt_local.cursorline = true end,
})
vim.api.nvim_create_autocmd('WinLeave', {
  group = bg_highlight,
  pattern = '*',
  callback = function() vim.opt_local.cursorline = false end,
})

-- User commands
vim.api.nvim_create_user_command('Writemode', function()
  vim.opt_local.wrap = true
  vim.opt_local.linebreak = true
  vim.opt_local.list = false
end, { nargs = '*' })

vim.api.nvim_create_user_command('Kernelmode', function()
  vim.opt_local.tabstop = 8
  vim.opt_local.softtabstop = 8
  vim.opt_local.shiftwidth = 8
  vim.opt_local.expandtab = false
end, { nargs = 0 })

-- Airline settings (legacy, non-functional without airline plugin)
vim.g.airline_detect_paste = 1
vim.g['airline#extensions#tabline#enabled'] = 1
vim.opt.laststatus = 2

-- LaTeX settings
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.tex',
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en_us'
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})
vim.opt.grepprg = 'grep -nH $*'
vim.g.tex_flavor = 'latex'
vim.g.Tex_FoldedSections = ''
vim.g.Tex_FoldedEnvironments = ''
vim.g.Tex_FoldedMisc = ''

-- fzf
vim.keymap.set('n', '<C-p>', function()
  vim.cmd('Files ' .. vim.fn.FindRootDirectory())
end)
vim.keymap.set('n', '<C-c>', '<cmd>Command<CR>')
vim.keymap.set('n', '<Leader>t', '<cmd>Tags<CR>')
vim.keymap.set('n', ';', '<cmd>Buffers<CR>')
vim.keymap.set('n', '<Leader>s', ':Rg <C-r><C-w><CR>')
vim.keymap.set('n', '<Leader>a', ':Rg <CR>')
vim.keymap.set('n', '<A-S-r>', '<cmd>History<CR>')
vim.keymap.set('n', '<C-h>', '<cmd>BCommits<CR>')
vim.keymap.set('n', '<A-h>', '<cmd>Commits<CR>')

-- Markdown
vim.g.vim_markdown_folding_disabled = 0
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '*.md', '*.MD' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})

-- NERDTree settings
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    if vim.fn.winnr('$') == 1 and vim.b.NERDTreeType == 'primary' then
      vim.cmd('quit')
    end
  end,
})
vim.g.NERDTreeShowHidden = 1
vim.keymap.set('n', '<Leader>n', '<cmd>NERDTreeFocus<CR>')

-- Gitgutter
vim.opt.updatetime = 250

-- EasyMotion
vim.g.EasyMotion_do_mapping = 0
vim.keymap.set('n', 's', '<Plug>(easymotion-overwin-f2)')
vim.g.EasyMotion_smartcase = 1
vim.keymap.set('n', '<Leader>j', '<Plug>(easymotion-j)')
vim.keymap.set('n', '<Leader>k', '<Plug>(easymotion-k)')

-- Matchit
if not vim.g.loaded_matchit and vim.fn.findfile('plugin/matchit.vim', vim.o.rtp) == '' then
  vim.cmd('runtime! macros/matchit.vim')
end

-- Goyo
local goyo_group = vim.api.nvim_create_augroup('GoyoLimelight', { clear = true })
vim.api.nvim_create_autocmd('User', {
  group = goyo_group,
  pattern = 'GoyoEnter',
  command = 'Limelight',
})
vim.api.nvim_create_autocmd('User', {
  group = goyo_group,
  pattern = 'GoyoLeave',
  command = 'Limelight!',
})
vim.g.goyo_width = 120

-- vim-rooter
vim.g.rooter_change_directory_for_non_project_files = 'current'
vim.g.rooter_silent_chdir = 1

-- Autoformat
vim.keymap.set('', '<F12>', '<cmd>Autoformat<CR>')
vim.g.autoformat_autoindent = 0
vim.g.autoformat_retab = 0
vim.g.autoformat_remove_trailing_spaces = 0
vim.g.formatters_python = { 'black' }

-- Undotree
vim.keymap.set('n', '<A-u>', '<cmd>UndotreeToggle<CR>')

-- Vimspector
vim.keymap.set('n', '<Leader>di', '<Plug>VimspectorBalloonEval')
vim.keymap.set('x', '<Leader>di', '<Plug>VimspectorBalloonEval')
vim.keymap.set('n', '<Leader>da', '<cmd>VimspectorReset<CR>')
vim.keymap.set('x', '<Leader>da', '<cmd>VimspectorReset<CR>')
vim.keymap.set('n', '<F5>', '<Plug>VimspectorContinue')
vim.keymap.set('n', '<F6>', '<Plug>VimspectorPause')
vim.keymap.set('n', '<F7>', '<Plug>VimspectorStop')
vim.keymap.set('n', '<F8>', '<Plug>VimspectorJumpToNextBreakpoint')
vim.keymap.set('n', '<F9>', '<Plug>VimspectorToggleBreakpoint')
vim.keymap.set('n', '<F10>', '<Plug>VimspectorStepOver')
vim.keymap.set('n', '<F11>', '<Plug>VimspectorStepInto')
vim.g.vimspector_sign_priority = {
  vimspectorBP = 400,
  vimspectorBPCond = 300,
  vimspectorBPLog = 200,
  vimspectorBPDisabled = 100,
  vimspectorPC = 999,
}

-- unimpaired (missing mappings)
vim.keymap.set('n', '[t', '<cmd>tabprevious<CR>')
vim.keymap.set('n', ']t', '<cmd>tabnext<CR>')

-- Floaterm bindings
vim.g.floaterm_height = 0.9
vim.g.floaterm_width = 0.9
vim.g.floaterm_keymap_toggle = '<Leader>tt'
vim.g.floaterm_keymap_prev = '<Leader>tp'
vim.g.floaterm_keymap_next = '<Leader>tn'
vim.g.floaterm_keymap_kill = '<Leader>tk'
vim.keymap.set('n', '<Leader>tg', '<cmd>FloatermNew lazygit<CR>')

-- Todo Comments
require('todo-comments').setup {}

-- Auto Dark Mode
require('auto-dark-mode').setup({
  update_interval = 3000,
  set_dark_mode = function()
    vim.api.nvim_set_option('background', 'dark')
    vim.cmd('colorscheme nord')
  end,
  set_light_mode = function()
    vim.api.nvim_set_option('background', 'light')
    vim.cmd('colorscheme one')
  end,
})

-- Lualine
require('lualine').setup {
  options = {
    icons_enabled = false,
  },
}
