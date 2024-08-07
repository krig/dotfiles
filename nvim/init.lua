-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- leader is space
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.autoformat = false

vim.opt.scrolloff = 4
vim.opt.conceallevel = 0
vim.opt.foldmethod = "indent"
vim.opt.completeopt = { "menu", "menuone" }
vim.opt.shortmess:append "c"
vim.opt.inccommand = "split"
vim.cmd([[au Filetype json set conceallevel=0]])

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "catppuccin" } },
  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Keymaps

-- move lines with visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Jump and recenter cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })
vim.keymap.set("n", "n", "nzz", { noremap = true })
vim.keymap.set("n", "N", "Nzz", { noremap = true })

-- Use Q to rerun last macro
vim.keymap.set("n", "Q", "@@", { noremap = true, desc = "Rerun last macro" })

-- open URLs in browser
vim.keymap.set("n", "gx", ":!open <c-r><c-a>", { desc = "Open URL" })

-- toggle relative line numbers
vim.keymap.set("n", "<leader>ur", function()
  require("lazyvim.util").toggle("relativenumber", true)
end, { desc = "Toggle Relative Line Numbers" })

vim.keymap.set('n', "<leader>d", function()
  local builtin = require('telescope.builtin')
  local utils = require('telescope.utils')
  builtin.find_files({ cwd = utils.buffer_dir() })
end, { desc = "Find files from current buffer" })

vim.keymap.set('n', "<leader>r", function()
  local builtin = require('telescope.builtin')
  builtin.resume()
end, { desc = "Resume last telescope buffer" })

vim.keymap.set('n', '<leader>cx', "<cmd>.lua<CR>", { desc = "Source the current line" })
vim.keymap.set('n', '<leader>cX', "<cmd>source %<CR>", { desc = "Source the current file" })

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
