-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

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

vim.keymap.set('n', "<leader>fd", function()
  local builtin = require('telescope.builtin')
  local utils = require('telescope.utils')
  builtin.find_files({ cwd = utils.buffer_dir() })
end, { desc = "Find files from current buffer" })

require('lazyvim.util').root_patterns = { ".git" }
