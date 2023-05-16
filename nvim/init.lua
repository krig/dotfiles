-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are required
-- (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- disable netrw in favor of nvimtree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function contains(s, target)
  return s:find(target, nil, true) ~= nil
end

local function stradd(s, target)
  if not contains(s, target) then
    return s .. target
  else
    return s
  end
end


-- General vim options
--
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.confirm = true -- ask to save
vim.o.autowrite = true -- write file when switching away from it
vim.o.shiftround = true -- round indent to multiple of shiftwidth
vim.o.wrap = false -- don't wrap long lines by default
vim.o.mouse = 'a' -- enable mouse in all modes
vim.o.breakindent = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.cursorline = true
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.signcolumn = 'auto'
vim.o.colorcolumn = ''
vim.o.scrolloff = 4
vim.o.hidden = true
vim.o.completeopt = 'menu,menuone,longest,noselect'
vim.o.formatoptions = stradd(vim.o.formatoptions, '/')
vim.o.formatoptions = stradd(vim.o.formatoptions, 'j')
vim.o.termguicolors = true -- enable true color in the terminal
vim.o.joinspaces = false



-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  use {
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'jose-elias-alvarez/null-ls.nvim',
      'jay-babu/mason-null-ls.nvim',
      'j-hui/fidget.nvim',
      'folke/neodev.nvim',
    },
  }

  use 'echasnovski/mini.align'
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap"} }
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
        'nvim-tree/nvim-web-devicons', -- optional, for file icons
      },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
  use 'stevearc/aerial.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }

  use { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter', }
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'kazhala/close-buffers.nvim'
  use 'akinsho/toggleterm.nvim'
  use 'mbbill/undotree'
  use 'tpope/vim-eunuch' -- unix utilities
  use 'tpope/vim-fugitive' -- Git interface
  use 'tpope/vim-rhubarb' -- Github interface
  use 'tpope/vim-jdaddy' -- json text objects
  use 'lewis6991/gitsigns.nvim' -- Git status in buffer gutter
  use 'tpope/vim-repeat' -- Repeat works in more places
  use 'tpope/vim-surround' -- Movement cmds for surrounds
  use 'nvim-lualine/lualine.nvim' -- Fancier statusline
  use 'jeffkreeftmeijer/vim-numbertoggle' -- toggle back to absolute linenum in insert mode
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
  use 'ahmedkhalf/project.nvim' -- Project management
  use 'ggandor/leap.nvim' -- easy motion
  use 'ggandor/flit.nvim' -- easy motion for fFtT commands
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }
  use { 'nvim-telescope/telescope-ui-select.nvim' }
  use { "nvim-telescope/telescope-file-browser.nvim" }
  use 'kkharji/sqlite.lua'
  use { 'danielfalk/smart-open.nvim', branch = '0.1.x', requires = {'kkharji/sqlite.lua' }, }
  use { 'folke/which-key.nvim' } -- popup with key bindings
  use 'junegunn/limelight.vim'
  use { 'jedrzejboczar/possession.nvim', requires = { 'nvim-lua/plenary.nvim' }, }
	use 'johnfrankmorgan/whitespace.nvim'
  use 'petertriho/nvim-scrollbar'
  use { 'ThePrimeagen/harpoon', requires = { 'nvim-lua/plenary.nvim' }, }

  -- Theme
  use { 'catppuccin/nvim', as = 'catppuccin' }
  use { 'rose-pine/neovim', as = 'rose-pine' }
  use 'owickstrom/vim-colors-paramount'
  use {
  "jesseleite/nvim-noirbuddy",
  requires = { "tjdevries/colorbuddy.nvim", branch = "dev" }
  }
  use 'logico/typewriter-vim'

  if is_bootstrap then
    require('packer').sync()
  end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set colorscheme
require("catppuccin").setup({
    flavour = "frappe",
})

require("rose-pine").setup {
  variant = 'moon',
  bold_vert_split = false,
  disable_italics = true,

  highlight_groups = {
    Comment = { fg = "muted", bg = "muted", blend = 10, italic = true },
  },
}
--
vim.cmd [[colorscheme catppuccin]]
-- vim.cmd [[colorscheme rose-pine]]
-- vim.cmd [[colorscheme typewriter]]
-- vim.cmd [[colorscheme paramount]]

-- vim.cmd [[colorscheme noirbuddy]]
-- require("noirbuddy").setup {
--   colors = {
--     background = '#ffffff',
--     primary = '#715bad',
--     secondary = '#afb599',
--   },
-- }

-- Options

-- Automatically open, but do not go to (if there are errors) the quickfix /
-- location list window, or close it when is has become empty.
--
-- Note: Must allow nesting of autocmds to enable any customizations for quickfix
-- buffers.
-- Note: Normally, :cwindow jumps to the quickfix window if the command opens it
-- (but not if it's already open). However, as part of the autocmd, this doesn't
-- seem to happen.
vim.cmd [[autocmd QuickFixCmdPost [^l]* nested cwindow]]
vim.cmd [[autocmd QuickFixCmdPost    l* nested lwindow]]

-- [[ Basic Keymaps ]]


-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

require('mini.align').setup()

require('whitespace-nvim').setup({
  -- configuration options and their defaults

  -- `highlight` configures which highlight is used to display
  -- trailing whitespace
  highlight = 'DiffDelete',

  -- `ignored_filetypes` configures which filetypes to ignore when
  -- displaying trailing whitespace
  ignored_filetypes = { 'TelescopePrompt', 'Trouble', 'help', 'aerial' },
})

-- remove trailing whitespace with a keybinding
vim.keymap.set('n', '<Leader>ww', require('whitespace-nvim').trim)


require('scrollbar').setup()


require('leap').add_default_mappings()

require('flit').setup {
  keys = { f = 'f', F = 'F', t = 't', T = 'T' },
  -- A string like "nv", "nvo", "o", etc.
  labeled_modes = "v",
  multiline = true,
  -- Like `leap`s similar argument (call-specific overrides).
  -- E.g.: opts = { equivalence_classes = {} }
  opts = {}
}

-- Greying out the search area
-- Or just set to grey directly, e.g. { fg = '#777777' },
-- if Comment is saturated.
vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })

require('which-key').setup()

-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    fmt = string.lower,
    icons_enabled = true,
    theme = 'auto',
    component_separators = '⋆',
    section_separators = '',
  },
}

-- Enable Comment.nvim
require('Comment').setup()


-- Configure project management
require('project_nvim').setup {
}

-- Close buffers
require('close_buffers').setup{}

vim.keymap.set('n', '<leader>bd',
  function() require('close_buffers').delete({type = 'this'}) end,
  { noremap = true, silent = true, desc = '[B]uffer [D]elete' })

vim.keymap.set('n', '<leader>bh',
  function() require('close_buffers').delete({type = 'hidden'}) end,
  { noremap = true, silent = true, desc = '[B]uffer del. [H]idden' })

-- Gitsigns
-- See `:help gitsigns.txt`
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}


require('harpoon').setup {
}


-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

require("telescope").load_extension('harpoon')
vim.keymap.set('n', '<leader>m', function() require('harpoon.ui').toggle_quick_menu() end, { desc="Toggle harpoon quick menu" })
vim.keymap.set('n', '<leader>n', function() require('harpoon.mark').add_file() end, { desc="mark file using harpoon" })
vim.keymap.set('n', '<leader>1', function() require('harpoon.ui').nav_file(1) end, { desc="nav to file using harpoon" })
vim.keymap.set('n', '<leader>2', function() require('harpoon.ui').nav_file(2) end, { desc="nav to file using harpoon" })
vim.keymap.set('n', '<leader>3', function() require('harpoon.ui').nav_file(3) end, { desc="nav to file using harpoon" })
vim.keymap.set('n', '<leader>4', function() require('harpoon.ui').nav_file(4) end, { desc="nav to file using harpoon" })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Map undotree
vim.keymap.set('n', '<leader>ut', vim.cmd.UndotreeToggle)
vim.keymap.set('n', 'U', ":redo<CR>", { noremap = true })

-- Keymap for whichkey
vim.keymap.set('n', '<leader>wk', function() vim.cmd('WhichKey') end, { desc = "[W]hich [K]key" })

-- move lines with visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Jump and recenter cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })
vim.keymap.set("n", "n", "nzz", { noremap = true })
vim.keymap.set("n", "N", "Nzz", { noremap = true })

-- paste into visual selection and retain paste buffer
vim.keymap.set("x", "<leader>p", "\"_dP", { noremap = true})

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Use Q to rerun last macro
vim.keymap.set("n", "Q", "@@", { noremap = true })

-- H and L = home/end?
-- vim.keymap.set("n", "H", "^", { noremap = true })
-- vim.keymap.set("n", "L", "$", { noremap = true })

-- use ctrl+[hjkl] to move between windows
vim.keymap.set("n", "<c-h>", "<c-w>h", { noremap = true})
vim.keymap.set("n", "<c-j>", "<c-w>j", { noremap = true})
vim.keymap.set("n", "<c-k>", "<c-w>k", { noremap = true})
vim.keymap.set("n", "<c-l>", "<c-w>l", { noremap = true})

-- don't exit visual mode while indenting
vim.cmd [[xnoremap < <gv]]
vim.cmd [[xnoremap > >gv]]

-- random leader commands

vim.keymap.set("n", "<leader>bb", vim.cmd.bprevious, { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bn", vim.cmd.bnext, { desc = "Next buffer" })
vim.keymap.set("n", "<leader>cd", function() vim.cmd [[:cd %:p:h
:pwd
]] end, { desc = "CD to current buffer" })

vim.keymap.set("n", "<leader>x", function() vim.cmd [[:e ~/scratch.md]] end, { desc = "Open scratch buffer" })

vim.keymap.set("n", "<leader>fc", vim.lsp.buf.format, { desc = "LSP: format whole buffer" })


local function setup_telescope()
  local telescope = require('telescope')
  local builtin = require('telescope.builtin')
  local themes = require('telescope.themes')

  -- Enable telescope fzf native, if installed
  pcall(telescope.load_extension, 'fzf')

  -- Enable telescope for possession
  pcall(telescope.load_extension, 'possession')

  -- Enable telescope for ui-select
  pcall(telescope.load_extension, 'ui-select')

  pcall(telescope.load_extension, 'file_browser')

  pcall(telescope.load_extension, 'smart_open')

  -- See `:help telescope.builtin`

  local function tele_cmdhistory()
    builtin.command_history(themes.get_ivy())
  end

  local function find_from_current_buffer()
    builtin.find_files({ cwd = vim.fn.expand('%:p:h') })
  end

  -- Quick commands
  vim.keymap.set('n', '<leader><leader>', telescope.extensions.smart_open.smart_open, { desc = 'Telescope smart open' })
  vim.keymap.set('n', '<leader>,', builtin.buffers, { desc = 'Find buffers' })
  vim.keymap.set('n', '<leader>.', builtin.git_files, { desc = '[G]it [F]iles' })
  vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = 'Fuzzy search current buffer' })
  vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Old files' })
  vim.keymap.set('n', '<leader>fp', builtin.resume, { desc = 'Resume previous telescope' })

  -- File related
  vim.keymap.set('n', '<leader>fv', telescope.extensions.file_browser.file_browser,
      { desc = '[F]ile [B]rowser' })
  vim.keymap.set('n', '<leader>ff', find_from_current_buffer, { desc = '[F]ind [F]rom current buffer' })
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
  vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = '[F]ind current [W]ord' })
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
  vim.keymap.set('n', '<leader>fd', builtin.fd, { desc = 'fd' })

  vim.keymap.set('n', '<leader>di', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })

  -- Git related
  vim.keymap.set('n', '<leader>gg', vim.cmd.Git, { desc = "[G]it [S]tatus" })
  vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = '[G]it [C]ommits' })
  vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = '[G]it [B]ranches' })

  -- Command history
  vim.keymap.set('n', '<C-r>', tele_cmdhistory, { noremap = true })

end

setup_telescope()

require('which-key').setup()

-- Configure toggleterm
require('toggleterm').setup {
  open_mapping = [[<leader>ts]],
  insert_mappings = false,
  direction = 'horizontal',
  shade_terminals = true,
}

local Terminal  = require('toggleterm.terminal').Terminal

local tig = Terminal:new({
  cmd = "tig",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})

function _tig_toggle()
  tig:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>lua _tig_toggle()<CR>", {noremap = true, silent = true})


-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'bash', 'c', 'cmake', 'cpp', 'lua', 'python', 'rust', 'javascript', 'json', 'help', 'vim' },

  highlight = {
    enable = true,
  },
  indent = { enable = true, disable = { 'python', 'cpp' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- context line
require 'treesitter-context'.setup {
  enable = true,
  line_numbers = true,
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, { desc = "Open diagnostic float" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Add diagnostics to location list" })

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>td', vim.lsp.buf.type_definition, '[T]ype [D]efinition')
  nmap('<leader>sd', require('telescope.builtin').lsp_document_symbols, '[S]ymbols in [D]ocument')
  nmap('<leader>sw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[S]ymbols in [W]orkspace')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<leader>ss', vim.lsp.buf.signature_help, '[S]how [S]ignature')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Setup neovim lua configuration
require('neodev').setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
})


-- Disable line numbers in terminal windows
local myaugroup = vim.api.nvim_create_augroup("Custom Settings", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.cmd "startinsert!"
  end,
  group = myaugroup,
  desc = "No line numbers in Terminal",
})

-- Terminal mode keymaps
vim.cmd [[tnoremap <Esc> <C-\><C-n>]]
vim.cmd [[tnoremap <C-v><Esc> <Esc>]]

-- Check if file has been updated when focusing the buffer
vim.api.nvim_create_autocmd("FocusGained", {
  callback = function()
    vim.cmd "checktime"
  end,
  group = myaugroup,
  desc = "Checktime on FocusGained",
})

-- Setup nvim-tree
require("nvim-tree").setup {
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      },
    },
  },
  filters = {
    dotfiles = true,
  },
  git = {
    ignore = true,
  },
}

-- aerial
require('aerial').setup{}
vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>')

-- setup nvimtree at startup
local function open_nvim_tree(data)
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- create a new empty buffer
  vim.cmd.enew()

  -- wipe directory buffer
  vim.cmd.bw(data.buf)

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open nvimtree
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

vim.keymap.set('n', '<leader>o',
    function ()
        local api = require('nvim-tree.api')
        api.tree.toggle{find_file=true, update_root=true, focus=true}
    end, { desc = 'Open [S]ide[b]ar' })

local function setup_dap()
  local dap = require('dap')
  dap.adapters.lldb = {
      type = 'executable',
      command = '/opt/homebrew/opt/llvm/bin/lldb-vscode',
      name = 'lldb',
  }

  dap.configurations.cpp = {
    {
      name = 'Launch',
      type = 'lldb',
      request = 'launch',
      program = function()
        return vim.fn.input {
          prompt = 'Path to executable: ',
          default = vim.fn.getcwd() .. '/',
          completion = 'file',
        }
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = {},
      runInTerminal = true,
    },
  }

  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp

  local dapui = require("dapui")
  dapui.setup()

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end

  -- setup keybindings
  vim.keymap.set('v', '<D-k>', dapui.eval, { noremap = true })
  vim.keymap.set('n', '<leader>bp', function() dap.toggle_breakpoint() end, { desc = "Toggle breakpoint" })
  vim.keymap.set('n', '<leader>bo', function() dap.repl.open() end, { desc = "Open debugger repl" })
  vim.keymap.set('n', '<leader>bl', function() dap.repl.open() end, { desc = "Debugger run last" })
  vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = "Continue" })
  vim.keymap.set('n', '<F8>', function() dap.step_over() end, { desc = "Step over" })
  vim.keymap.set('n', '<F9>', function() dap.step_into() end, { desc = "Step into" })
  vim.keymap.set('n', '<F10>', function() dap.step_out() end, { desc = "Step out" })
end

setup_dap()

local place = vim.fn.system("place")

-- Neovide configuration
if vim.g.neovide then
  vim.g.neovide_cursor_vfx_mode = "railgun"
  --vim.opt.guifont = { "Ligconsolata,Noto_Color_Emoji", ":h20" }
  --vim.opt.guifont = { "Cascadia Code,Noto_Color_Emoji", ":h18" }
  local neovide_font = "Cascadia Mono PL,Noto_Color_Emoji"
  if place:find("home") then
    -- vim.opt.guifont = { "Pragmasevka Nerd Font,Noto_Color_Emoji", ":h14" }
    vim.opt.guifont = { neovide_font, ":h16" }
  else
    -- vim.opt.guifont = { "Pragmasevka Nerd Font,Noto_Color_Emoji", ":h20" }
    vim.opt.guifont = { neovide_font, ":h20" }
  end

  -- vim.opt.guifont = { "Cartograph CF,Noto_Color_Emoji", ":h16" }
  --vim.opt.guifont = { "DM Mono,Noto_Color_Emoji", ":h16" }
  --vim.opt.guifont = { "Victor Mono,Noto_Color_Emoji", ":h16" }

  vim.g.neovide_input_use_logo = 1 -- enable use of the logo (cmd) key
  vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
  vim.keymap.set('v', '<D-c>', '"+y') -- Copy
  vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
end

-- Allow clipboard copy paste in neovim
vim.g.neovide_input_use_logo = 1
vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})


-- Setup mason so it can manage external tooling
require('mason').setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  bashls = {},
  clangd = {},
  cmake = {},
  pyright = {},

  lua_ls = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      library = vim.api.nvim_get_runtime_file("", true),
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    local lspconfig = require('lspconfig')
    if lspconfig[server_name].setup == nil then
      return
    end
    lspconfig[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      autostart = false,
    }
  end,
}

-- Turn on lsp status information
require('fidget').setup()

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- configure null-ls

local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.completion.spell,
  },
})

require('mason-null-ls').setup()

-- vim: ts=2 sts=2 sw=2 et
