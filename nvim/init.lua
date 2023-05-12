--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- disable netrw in favor of nvimtree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd [[ set rtp+=/opt/homebrew/opt/fzf ]]

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local function setup_telescope()
  local telescope = require('telescope')
  local builtin = require('telescope.builtin')
  local themes = require('telescope.themes')

  -- Enable telescope fzf native, if installed
  pcall(telescope.load_extension, 'fzf')

  -- Enable telescope for ui-select
  pcall(telescope.load_extension, 'ui-select')

  -- See `:help telescope.builtin`

  local function tele_fuzzy_find()
    builtin.live_grep({
      prompt_title = 'find string in open buffers',
      grep_open_files = true
    })
  end

  local function tele_cmdhistory()
    builtin.command_history(themes.get_ivy())
  end

  local function find_from_current_buffer()
    local utils = require('telescope.utils')
    builtin.find_files({ cwd = utils.buffer_dir()})
  end

  -- Quick commands
  vim.keymap.set('n', '<leader><leader>', find_from_current_buffer, { desc = 'Find from current buffer' })
  vim.keymap.set('n', '<leader>,', builtin.buffers, { desc = 'Find buffers' })
  vim.keymap.set('n', '<leader>/', tele_fuzzy_find, { desc = 'Fuzzy search open buffers' })
  vim.keymap.set('n', '<leader>r', builtin.oldfiles, { desc = 'Recently opened files' })

  vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Find Diagnostics' })
  vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find Help' })
  vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Find Resume' })
  vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Find Word' })
  vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Git Branches' })
  vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Git Commits' })
  vim.keymap.set('n', '<leader>gg', builtin.git_files, { desc = 'Git Files' })
  vim.keymap.set('n', '<leader>gr', builtin.live_grep, { desc = 'Live Grep' })
  vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = "Git Status" })

  -- Command history
  vim.keymap.set('n', '<C-r>', tele_cmdhistory, { noremap = true, desc = "Command history" })

end

require("lazy").setup(
  {
    { 'rose-pine/neovim',
      name = 'rose-pine',
      lazy = false,
      priority = 1000,
      config = function()
        require('rose-pine').setup({
          variant = 'dawn',
          dark_variant = 'moon',
          options = {
            terminal_colors = true,
            dim_inactive = true,
            styles = {
              comments = 'italic',
            },
          },
        })
        vim.cmd('colorscheme rose-pine')
      end,
    },
    "folke/which-key.nvim",
    'echasnovski/mini.align',
    'mbbill/undotree',
    'tpope/vim-fugitive',
    'tpope/vim-repeat',
    'tpope/vim-surround',
    'tpope/vim-sleuth',
    {
      'lewis6991/gitsigns.nvim',
      opts = {
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
      }
    },
    'numToStr/Comment.nvim',
    {
      'ggandor/leap.nvim',
      config = function()
        require('leap').add_default_mappings()
      end,
    },
    {
      'ggandor/flit.nvim',
      opts = {
        keys = { f = 'f', F = 'F', t = 't', T = 'T' },
        -- A string like "nv", "nvo", "o", etc.
        labeled_modes = "v",
        multiline = true,
        -- Like `leap`s similar argument (call-specific overrides).
        -- E.g.: opts = { equivalence_classes = {} }
        opts = {}
      },
    },
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        require('nvim-treesitter.configs').setup {
          highlight = {
            enable = true,
            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
          },
        }
      end,
    },
    {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.1',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('telescope').setup()
        setup_telescope()
      end,
    },
    'nvim-telescope/telescope-fzf-native.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        require("nvim-tree").setup {}
        vim.keymap.set('n', '<leader>o', vim.cmd.NvimTreeToggle, { desc = "Nvim Tree" })
      end,
    },
    {
      'goolord/alpha-nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
        require('config.alpha')
      end,
    },
  })

-- See `:help vim.o`
vim.o.termguicolors = true
vim.o.hlsearch = false
vim.o.incsearch = true
vim.wo.number = true
vim.o.relativenumber = true
vim.o.confirm = true
vim.o.autowrite = true
vim.o.shiftround = true
vim.o.wrap = false
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.signcolumn = 'auto'
vim.o.colorcolumn = '140'
vim.o.scrolloff = 8
vim.o.hidden = true
vim.o.completeopt = 'menu,menuone,longest,noselect'
vim.o.formatoptions = vim.o.formatoptions .. '/'

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

-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})


-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Map undotree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = "Toggle Untotree"})
vim.keymap.set('n', 'U', ":redo<CR>", { noremap = true })

-- Keymap for whichkey
vim.keymap.set('n', '<leader>w', function() vim.cmd('WhichKey') end, { desc = "Which key" })

-- move lines with visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Jump and recenter cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })
vim.keymap.set("n", "n", "nzz", { noremap = true })
vim.keymap.set("n", "N", "Nzz", { noremap = true })

-- paste into visual selection and retain paste buffer
vim.keymap.set("x", "<leader>p", "\"_dP", { noremap = true, desc = "Paste and retain paste buffer" })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Use Q to rerun last macro
vim.keymap.set("n", "Q", "@@", { noremap = true, desc = "Rerun last macro" })

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

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, { desc = "Open diagnostic float" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Add diagnostics to location list" })


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

-- Neovide configuration
if vim.g.neovide then
  vim.g.neovide_cursor_vfx_mode = ""
  vim.opt.guifont = { "Cartograph CF,Noto_Color_Emoji", ":h16" }

  vim.g.neovide_input_use_logo = 1 -- enable use of the logo (cmd) key
  vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
  vim.keymap.set('v', '<D-c>', '"+y') -- Copy
  vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
  vim.g.neovide_input_use_logo = 1
end

-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})

-- vim: ts=2 sts=2 sw=2 et
