local g = vim.g
local o = vim.opt

g.autoformat = true
g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }
g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB

g.markdown_recommended_style = 0   -- Fix markdown indentation settings
g.markdown_syntax_conceal = 0
g.markdown_fenced_languages = {
  "ts=typescript",
  "html",
  "python",
  "bash=sh",
}
vim.cmd [[autocmd FileType markdown set tw=80 wrap]]

o.autowrite = true
o.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
o.completeopt = { "menu", "menuone" }
o.conceallevel = 0
o.confirm = true   -- Confirm to save changes before exiting modified buffer
o.expandtab = true -- Use spaces instead of tabs
o.foldmethod = "manual"
o.grepformat = "%f:%l:%c:%m"
o.grepprg = "rg --vimgrep"
o.ignorecase = true
o.inccommand = "split"
o.jumpoptions = "view"
o.laststatus = 3   -- global statusline
o.linebreak = true -- Wrap lines at convenient points
o.list = false      -- Show some invisible characters (tabs...
o.listchars = "tab:> ,trail:×"
o.mouse = "a"
o.number = false
o.relativenumber = false
o.pumblend = 10     -- Popup blend
o.pumheight = 10    -- Maximum number of entries in a popup
o.scrolloff = 4     -- Lines of context
o.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
o.shiftround = true -- Round indent
o.shiftwidth = 2    -- Size of an indent
o.shortmess:append "c"
o.shortmess:append({ W = true, I = true, c = true, C = true })
o.showmode = false  -- Dont show mode since we have a statusline
o.sidescrolloff = 8 -- Columns of context
o.signcolumn = "yes"
o.smartcase = true
o.smartindent = true
o.smoothscroll = true
o.spelllang = { "en" }
o.spelloptions:append("noplainbuffer")
o.splitbelow = true
o.splitkeep = "screen"
o.splitright = true
o.synmaxcol = 500
o.tabstop = 2          -- Number of spaces tabs count for
o.termguicolors = true -- True color support
o.undofile = true
o.undolevels = 10000
o.updatetime = 200               -- Save swap file and trigger CursorHold
o.virtualedit = "block"          -- Allow cursor to move where there is no text in visual block mode
o.wildmode = "longest:full,full" -- Command-line completion mode
o.winminwidth = 5                -- Minimum window width
o.wrap = true                    -- Disable line wrap
-- o.formatoptions:append('a')

-- cursorline off in insert mode
vim.cmd [[autocmd InsertLeave,WinEnter * set cursorline]]
vim.cmd [[autocmd InsertEnter,WinLeave * set nocursorline]]

-- highlight yanked text
vim.cmd [[autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup='Visual'}]]
