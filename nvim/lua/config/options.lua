-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
opt.scrolloff = 4
opt.conceallevel = 0
opt.foldmethod = "indent"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess:append "c"
opt.inccommand = "split"

vim.cmd([[au Filetype json set conceallevel=0]])
vim.g.autoformat = false
