
-- Keymaps

-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>bo", "<cmd>e #<cr>", { desc = "Other Buffer" })
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "escape clears hlsearch" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- move lines with visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>lz", "<cmd>Lazy<cr>", { desc = ":Lazy" })

vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

vim.keymap.set("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
vim.keymap.set("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- diagnostic
local function diagnostic_goto(go, severity)
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

local go_next = vim.diagnostic.goto_next
local go_prev = vim.diagnostic.goto_prev

vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.keymap.set("n", "]d", diagnostic_goto(go_next), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(go_prev), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(go_next, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(go_prev, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(go_next, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(go_prev, "WARN"), { desc = "Prev Warning" })

vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })
vim.keymap.set("n", "<leader>qa", "<cmd>qa<cr>", { desc = "Quit All" })

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

-- windows
vim.keymap.set("n", "<leader>w", "<c-w>", { desc = "Windows", remap = true })

-- Jump and recenter cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })
vim.keymap.set("n", "n", "nzz", { noremap = true })
vim.keymap.set("n", "N", "Nzz", { noremap = true })

-- Use Q to rerun last macro
vim.keymap.set("n", "Q", "@@", { noremap = true, desc = "Rerun last macro" })

-- open URLs in browser
vim.keymap.set("n", "gx", ":!open <c-r><c-a>", { desc = "Open URL" })

vim.keymap.set('n', '<leader>cx', "<cmd>.lua<CR>", { desc = "Source the current line" })
vim.keymap.set('n', '<leader>cX', "<cmd>source %<CR>", { desc = "Source the current file" })

-- edit macro
vim.keymap.set('n', '<leader>me', "<cmd><c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>", { desc = "Edit macro" })

-- alternate file
-- :e#
vim.keymap.set('n', 'go', '<cmd>e#<cr>', { desc = "Go to alternate file" })

-- needs various-textobjs plugin
vim.keymap.set("n", "<leader>ou", function()
	-- select URL
	require("various-textobjs").url()

	-- plugin only switches to visual mode when textobj is found
	local foundURL = vim.fn.mode() == "v"
	if not foundURL then return end

	-- retrieve URL with the z-register as intermediary
	vim.cmd.normal { '"zy', bang = true }
	local url = vim.fn.getreg("z")
	vim.ui.open(url) -- requires nvim 0.10
end, { desc = "URL Opener" })

vim.keymap.set('n', '<leader>zz', '<cmd>close<cr>', { desc = "Close" })
