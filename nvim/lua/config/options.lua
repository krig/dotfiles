-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.o.scrolloff = 4
vim.o.conceallevel = 0
vim.cmd([[au Filetype json set conceallevel=0]])
vim.g.autoformat = false

vim.g.root_spec = { { ".git" }, "cwd" }
vim.opt.foldmethod = "indent"
