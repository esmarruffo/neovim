--------------------------------------------------------------------------------
-- init.lua — converted from init.vim
--------------------------------------------------------------------------------

-- Leader keys (must be set before loading plugins)
vim.g.mapleader = ' '
vim.g.maplocalleader = '`'
vim.keymap.set('n', '<Space>', '<Nop>', { silent = true })

--------------------------------------------------------------------------------
-- Bootstrap lazy.nvim
--------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--------------------------------------------------------------------------------
-- Plugin variables (set before plugins load)
--------------------------------------------------------------------------------
vim.g.clang_library_path = '/usr/lib/llvm15/lib'
-- vim.g.rainbow_active removed — using rainbow-delimiters.nvim now
vim.g.sql_type_default = 'pgsql'
vim.g.python3_host_prog = '/usr/bin/python3'
vim.g.python_host_prog = '/usr/bin/python'

-- Jedi
vim.g['jedi#auto_initialization'] = 1
vim.g['jedi#completions_enabled'] = 1
vim.g['jedi#auto_vim_configuration'] = 0
vim.g['jedi#smart_auto_mappings'] = 0
vim.g['jedi#popup_on_dot'] = 1
vim.g['jedi#completions_command'] = ''
vim.g['jedi#show_call_signatures'] = '1'
vim.g['jedi#show_call_signatures_delay'] = 0
vim.g['jedi#use_tabs_not_buffers'] = 0
vim.g['jedi#show_call_signatures_modes'] = 'i'
vim.g['jedi#enable_speed_debugging'] = 0

-- Gitgutter
vim.g.gitgutter_override_sign_column_highlight = 0
vim.g.gitgutter_map_keys = 0

--------------------------------------------------------------------------------
-- Plugins
--------------------------------------------------------------------------------
require('lazy').setup({
  'scrooloose/nerdtree',
  'majutsushi/tagbar',
  {
    'HiPhish/rainbow-delimiters.nvim',
    config = function()
      require('rainbow-delimiters.setup').setup({})
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = {
          icons_enabled = true,
          theme = 'gruvbox',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = { statusline = {}, winbar = {} },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = { statusline = 1000, tabline = 1000, winbar = 1000 },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      })
    end,
  },
  'airblade/vim-gitgutter',
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },
  {
    'MagicDuck/grug-far.nvim',
    config = function()
      require('grug-far').setup()
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },
  'Raimondi/delimitMate',
  'tpope/vim-surround',
  'ryanoasis/vim-devicons',
  {
    'nvim-telescope/telescope.nvim',

    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      local telescope = require('telescope')
      telescope.setup({
        defaults = {
          file_ignore_patterns = { 'node_modules', '.git/', 'build/' },
          mappings = {
            i = {
              ['<C-j>'] = 'move_selection_next',
              ['<C-k>'] = 'move_selection_previous',
            },
          },
        },
      })
      -- Use fzf-native for faster sorting (if compiled successfully)
      pcall(telescope.load_extension, 'fzf')
    end,
  },
  {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('gruvbox').setup({
        transparent_mode = true,
      })
      vim.cmd.colorscheme('gruvbox')
    end,
  },
    -- Treesitter (incremental syntax parsing, replaces regex-based highlighting)
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      -- Disable legacy regex syntax — treesitter handles all highlighting
      -- Reapply colorscheme after, since 'syntax off' runs 'highlight clear'
      local colorscheme = vim.g.colors_name
      vim.cmd('syntax off')
      if colorscheme then
        vim.cmd.colorscheme(colorscheme)
      end
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('TreesitterStart', { clear = true }),
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
  -- C/C++ and low-level
  'tikhomirov/vim-glsl',
  -- Python
  'Vimjas/vim-python-pep8-indent',

  -- Autocompletion
  {
    'saghen/blink.cmp',
    version = '1.*',
    opts = {
      keymap = {
        preset = 'default',
        ['<CR>'] = { 'fallback' },
        ['<Tab>'] = { 'accept', 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide', 'fallback' },
      },
      completion = {
        documentation = { auto_show = true },
        menu = { auto_show = true },
      },
      sources = {
        default = { 'lsp', 'path', 'buffer' },
      },
    },
  },

  -- LSP (mason for auto-installing servers)
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },

  -- Folding
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    config = function()
      require('ufo').setup({
        -- Use LSP when available, fall back to indent
        provider_selector = function(_, filetype, _)
          if filetype == 'python' then
            return { 'lsp', 'indent' }
          end
          return { 'lsp', 'indent' }
        end,
      })
    end,
  },
})

--------------------------------------------------------------------------------
-- LSP servers (native vim.lsp.config, Neovim 0.11+)
--------------------------------------------------------------------------------
local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
-- Tell servers we support folding ranges (for nvim-ufo)
lsp_capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- Python
vim.lsp.config('zuban', {
  cmd = { 'zuban', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', '.git' },
  capabilities = lsp_capabilities,
})

-- C/C++
vim.lsp.config('clangd', {
  capabilities = lsp_capabilities,
})

-- Lua (for Neovim config editing)
vim.lsp.config('lua_ls', {
  capabilities = lsp_capabilities,
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      workspace = { library = vim.api.nvim_get_runtime_file('', true) },
    },
  },
})

-- Swift
vim.lsp.config('sourcekit', {
  cmd = { 'sourcekit-lsp' },
  filetypes = { 'swift', 'objc', 'objcpp' },
  root_markers = { 'buildServer.json', 'Package.swift', '.git' },
  capabilities = lsp_capabilities,
})

-- Kotlin (Android)
vim.lsp.config('kotlin_ls', {
  cmd = { 'kotlin-lsp' },
  cmd_env = { ANDROID_HOME = vim.env.ANDROID_HOME or (vim.env.HOME .. '/Library/Android/sdk') },
  filetypes = { 'kotlin' },
  root_markers = { 'settings.gradle', 'settings.gradle.kts', 'build.gradle', 'build.gradle.kts' },
  capabilities = lsp_capabilities,
})

-- TypeScript / React Native
vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  root_markers = { 'tsconfig.json', 'package.json', '.git' },
  capabilities = lsp_capabilities,
})

vim.lsp.enable({ 'zuban', 'clangd', 'lua_ls', 'sourcekit', 'kotlin_ls', 'ts_ls' })

-- LSP keybindings (set when a server attaches to a buffer)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('LspKeymaps', { clear = true }),
  callback = function(args)
    local bmap = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc })
    end
    bmap('n', '<F12>', vim.lsp.buf.definition, 'Go to definition')
    bmap('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
    bmap('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
    bmap('n', 'gr', vim.lsp.buf.references, 'References')
    bmap('n', 'K', vim.lsp.buf.hover, 'Hover docs')
    bmap('n', '<F2>', vim.lsp.buf.rename, 'Rename symbol')
    bmap('n', '<leader>ca', vim.lsp.buf.code_action, 'Code action')
    bmap('n', '<leader>d', vim.diagnostic.open_float, 'Line diagnostics')
    bmap('n', '[d', vim.diagnostic.goto_prev, 'Prev diagnostic')
    bmap('n', ']d', vim.diagnostic.goto_next, 'Next diagnostic')

    -- Highlight all occurrences of the word under cursor
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method('textDocument/documentHighlight') then
      local hl_group = vim.api.nvim_create_augroup('LspDocumentHighlight', { clear = false })
      vim.api.nvim_clear_autocmds({ group = hl_group, buffer = args.buf })
      vim.api.nvim_create_autocmd('CursorHold', {
        group = hl_group,
        buffer = args.buf,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd('CursorMoved', {
        group = hl_group,
        buffer = args.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

--------------------------------------------------------------------------------
-- Options
--------------------------------------------------------------------------------
vim.cmd('filetype indent on')

vim.opt.fileformat = 'unix'
vim.opt.shortmess:append('c')
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrapscan = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.fillchars:append({ vert = ' ' })

vim.opt.history = 1000

vim.opt.breakindent = true
vim.opt.showbreak = '..'
vim.opt.wrap = false

vim.opt.scrolloff = 3

vim.opt.undodir = vim.fn.expand('~/.vim/undodir')
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.undoreload = 100000

vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.laststatus = 2

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.cpoptions:append('x')

vim.opt.errorbells = false
vim.opt.visualbell = true
vim.opt.shada = "'20,<1000"

vim.opt.timeoutlen = 500
vim.opt.redrawtime = 1000

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.signcolumn = 'yes'
vim.opt.clipboard = 'unnamedplus'

-- Folding (nvim-ufo takes over fold management)
vim.opt.foldcolumn = '1'
vim.opt.foldlevel = 99      -- start with all folds open
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

vim.o.autoread = true
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*",
  command = "checktime",
})


--------------------------------------------------------------------------------
-- Key mappings
--------------------------------------------------------------------------------
local map = vim.keymap.set

-- Paste without overwriting register
map('n', '<leader>p', '"_dP', { noremap = true, silent = true })

-- Tab navigation
map('n', 'tn', ':tabnew ', { noremap = true })
map('n', 'tk', ':tabnext<CR>', { noremap = true })
map('n', 'tj', ':tabprev<CR>', { noremap = true })
map('n', 'th', ':tabfirst<CR>', { noremap = true })
map('n', 'tl', ':tablast<CR>', { noremap = true })

-- Easier split navigation
map('n', '<C-J>', '<C-W><C-J>', { noremap = true })
map('n', '<C-K>', '<C-W><C-K>', { noremap = true })
map('n', '<C-L>', '<C-W><C-L>', { noremap = true })
map('n', '<C-H>', '<C-W><C-H>', { noremap = true })

-- Escape mappings
map('i', '<F13>', '<Esc>')
map('c', '<Esc>', '<C-c>', { noremap = true })
map('i', '<C-c>', '<ESC>', { noremap = true })
map('n', '<C-z>', '<Esc>', { noremap = true })

-- Replace current word with pasteboard
map('n', 'S', 'diw"0P', { noremap = true })
map('n', 'cc', '"_cc', { noremap = true })

-- Delete to black hole register
map('n', 'x', '"_x', { noremap = true })
map('v', 'x', '"_x', { noremap = true })

-- NERDTree and Tagbar
map('n', '<C-n>', ':NERDTreeToggle<CR>')
map('n', '<C-t>', ':set nosplitright<CR>:TagbarToggle<CR>:set splitright<CR>')

-- Quick save and quit
map('n', '<leader>w', ':w!<CR>', { noremap = true })
map('n', '<leader>q', ':lcl<CR>:q<CR>', { noremap = true })
map('n', '<leader>h', ':nohlsearch<Bar>:echo<CR>', { noremap = true })

-- Telescope
local builtin = require('telescope.builtin')
map('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
map('n', '<leader><leader>', builtin.find_files, { desc = 'Find files (quick)' })
map('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
map('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
map('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
map('n', '<leader>fo', builtin.oldfiles, { desc = 'Recent files' })
map('n', '<leader>fw', builtin.grep_string, { desc = 'Grep word under cursor' })
map('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Document symbols' })
map('n', '<leader>gc', builtin.git_commits, { desc = 'Git commits' })
map('n', '<leader>gs', builtin.git_status, { desc = 'Git status' })

-- Search & replace (grug-far)
map('n', '<leader>sr', function() require('grug-far').open() end, { desc = 'Search & replace' })
map('v', '<leader>sr', function() require('grug-far').with_visual_selection() end, { desc = 'Search & replace (selection)' })
map('n', '<leader>sw', function()
  require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>') } })
end, { desc = 'Search & replace (word)' })

-- Git
map('n', '<leader>=', ':GitGutterNextHunk<CR>', { desc = 'Go to next diff hunk' })
map('n', '<leader>-', ':GitGutterPrevHunk<CR>', { desc = 'Go to next diff hunk' })


-- Diffview
map('n', '<leader>gd', ':DiffviewOpen<CR>', { desc = 'Open diff view' })
map('n', '<leader>gf', ':DiffviewFileHistory %<CR>', { desc = 'File history (current)' })
map('n', '<leader>gq', ':DiffviewClose<CR>', { desc = 'Close diff view' })

-- Folding (nvim-ufo)
map('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
map('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })
map('n', 'zK', require('ufo').peekFoldedLinesUnderCursor, { desc = 'Peek fold' })

-- Go to tab by number
for i = 1, 9 do
  map('n', '<leader>' .. i, i .. 'gt', { noremap = true })
end
map('n', '<leader>0', ':tablast<CR>', { noremap = true })

-- Disable terminal ctrl-z, ctrl-a, ctrl-x in normal mode
map('n', '<C-a>', '<Esc>', { noremap = true })
map('n', '<C-x>', '<Esc>', { noremap = true })

-- Remove trailing whitespace (F5)
map('n', '<F5>', function()
  local save_cursor = vim.fn.getpos('.')
  local save_search = vim.fn.getreg('/')
  vim.cmd([[%s/\s\+$//e]])
  vim.fn.setpos('.', save_cursor)
  vim.fn.setreg('/', save_search)
end, { noremap = true, silent = true })

--------------------------------------------------------------------------------
-- Autocommands
--------------------------------------------------------------------------------

-- Python breakpoints
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('PythonBreakpoints', { clear = true }),
  pattern = 'python',
  callback = function()
    map('n', '<leader>b', 'ofrom pudb import set_trace; set_trace()<Esc>', { buffer = true, silent = true })
    map('n', '<leader>B', 'Ofrom pudb import set_trace; set_trace()<Esc>', { buffer = true, silent = true })
    map('n', '<leader>j', 'ofrom pdb import set_trace; set_trace()<Esc>', { buffer = true, silent = true })
    map('n', '<leader>J', 'Ofrom pdb import set_trace; set_trace()<Esc>', { buffer = true, silent = true })
  end,
})

-- Quickfix: make Enter follow the entry
vim.api.nvim_create_autocmd('BufReadPost', {
  group = vim.api.nvim_create_augroup('QuickfixEnter', { clear = true }),
  pattern = 'quickfix',
  callback = function()
    map('n', '<CR>', '<CR>', { buffer = true, noremap = true })
  end,
})

-- NOTE: Custom syntax regex autocmds removed — treesitter handles highlighting now

--------------------------------------------------------------------------------
-- Highlights
--------------------------------------------------------------------------------
vim.api.nvim_set_hl(0, 'VertSplit', { ctermbg = 253 })
vim.api.nvim_set_hl(0, 'pythonImportedObject', { ctermfg = 127 })
vim.api.nvim_set_hl(0, 'pythonImportedFuncDef', { ctermfg = 127 })
vim.api.nvim_set_hl(0, 'pythonImportedClassDef', { ctermfg = 127 })
