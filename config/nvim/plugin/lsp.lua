-- Diagnostic mappings
vim.keymap.set('n', '<Leader>d', vim.diagnostic.open_float, { silent = true })
vim.keymap.set('n', '<Leader>D', vim.diagnostic.setloclist, { silent = true })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { silent = true })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { silent = true })

-- LSP buffer mappings, set after a language server attaches
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local map = function(key, fn)
      vim.keymap.set('n', key, fn, { buffer = bufnr, silent = true })
    end
    map('gd', vim.lsp.buf.definition)
    map('gD', vim.lsp.buf.type_definition)
    map('gi', vim.lsp.buf.implementation)
    map('<C-k>', vim.lsp.buf.signature_help)
    map('<F1>', vim.lsp.buf.hover)
    map('<F2>', vim.lsp.buf.rename)
    map('<F3>', function() vim.lsp.buf.references({ includeDeclaration = false }) end)
    map('<F4>', vim.lsp.buf.code_action)
    map('<F12>', function() vim.lsp.buf.format({ timeout_ms = 2000 }) end)

    -- Disable ruff hover in favor of pyright
    if client and client.name == 'ruff' then
      client.server_capabilities.hoverProvider = false
    end
  end,
})

vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})

vim.lsp.config('pyright', {
  settings = {
    pyright = {
      disableOrganizeImports = true, -- ruff handles this
    },
  },
})

-- finally, enable the servers
vim.lsp.enable({
  'rust_analyzer',
  'clangd',
  'pyright',
  'ruff',
  'lua_ls',
})

-- lazydev.nvim: configures lua_ls for Neovim config/plugin development
require('lazydev').setup()

-- blink.cmp setup
require('blink.cmp').setup({
  keymap = {
    preset = 'default',
    ['<C-d>'] = { 'scroll_documentation_up' },
    ['<C-f>'] = { 'scroll_documentation_down' },
    ['<C-Space>'] = { 'show' },
    ['<CR>'] = { 'accept', 'fallback' },
    ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
  },
  completion = {
    documentation = { auto_show = true },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
    providers = {
      lazydev = {
        name = 'LazyDev',
        module = 'lazydev.integrations.blink',
        score_offset = 100,
      },
    },
  },
})
