local map = vim.keymap.set
local extend = vim.tbl_extend
local opt = { noremap = true, silent = true }
vim.g.maplocalleader = ","

map("n", "<ESC>", "<CMD>noh<CR>", opt) -- Remove highlights from search result

-- map("n", "<BS>", "<C-^>zz", { desc = "Jump to last Buffer" }, opt) -- Jump to last buffer

-- Remove annoying exmode
map("n", "Q", "<Nop>", opt)
map("n", "q:", "<Nop>", opt)

-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", extend("force", opt, { expr = true, desc = "Check for line wrapping" }))

map("n", "j", "v:count == 0 ? 'gj' : 'j'", extend("force", opt, { expr = true, desc = "Check for line wrapping" }))

map("n", "H", "^", extend("force", opt, { desc = "goto beginning of line" }))
map("n", "L", "$", extend("force", opt, { desc = "goto end of line" }))

-- resizing window with <ctrl> and arrow
map("n", "<C-Up>", "<cmd>resize +2<cr>", extend("force", opt, { desc = "Increase window height" }))
map("n", "<C-Down>", "<cmd>resize -2<cr>", extend("force", opt, { desc = "Decrease window height" }))
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", extend("force", opt, { desc = "Decrease window width" }))
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", extend("force", opt, { desc = "Increase window width" }))

-- Better Window Navigation using <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", extend("force", opt, { desc = "Go to left window " }))
map("n", "<C-j>", "<C-w>j", extend("force", opt, { desc = "Go to lower window " }))
map("n", "<C-k>", "<C-w>k", extend("force", opt, { desc = "Go to upper window " }))
map("n", "<C-l>", "<C-w>l", extend("force", opt, { desc = "Go to right window " }))

-- better indenting
map("v", "<", "<gv", extend("force", opt, { desc = "Indent Left" }))
map("v", ">", ">gv", extend("force", opt, { desc = "Indent Right" }))

-- Replace selected text without yanking it
map("v", "p", '"_dP', extend("force", opt, { desc = "Paste without yanking" }))

-- Move line(s) up and down
map("n", "<M-j>", ":m .+1<CR>==", extend("force", opt, { desc = "Move line down" }))
map("n", "<M-k>", ":m .-2<CR>==", extend("force", opt, { desc = "Move line up" }))
map("v", "<M-j>", ":m '>+1<CR>==gv=gv", extend("force", opt, { desc = "Move line down" }))
map("v", "<M-k>", ":m '<-2<CR>==gv=gv", extend("force", opt, { desc = "Move line up" }))

-- Move selected line / block of text in visual mode
map("x", "K", ":move '<-2<CR>gv-gv", extend("force", opt, { desc = "Move selected visual line up" }))
map("x", "J", ":move '>+1<CR>gv-gv", extend("force", opt, { desc = "Move selected visual line down" }))

-- navigate within insert mode
-- map("i", "<C-h>", "<Left>") -- "   move left"
-- map("i", "<C-l>", "<Right>") -- " move right"
-- map("i", "<C-j>", "<Down>") -- " move down"
-- map("i", "<C-k>", "<Up>") -- " move up" },

-- Prevent typo when pressing `wq` or `q`
vim.cmd([[
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))
cnoreabbrev <expr> WQ ((getcmdtype() is# ':' && getcmdline() is# 'WQ')?('wq'):('WQ'))
cnoreabbrev <expr> Wq ((getcmdtype() is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))
]])

-- Diagnostic keymaps
map("n", "<localleader>d", vim.diagnostic.open_float, extend("force", opt, { desc = "Open Diagnostic Float Window" }))
map("n", "[d", vim.diagnostic.goto_prev, extend("force", opt, { desc = "Goto previous diagnostic" }))
map("n", "]d", vim.diagnostic.goto_next, extend("force", opt, { desc = "Goto next diagnostic" }))
map(
  "n",
  "<localleader>q",
  vim.diagnostic.setloclist,
  extend("force", opt, { desc = "Show diagnostic in quickfix list" })
)

map({ "i", "n" }, "<C-s>", "<cmd>w<cr>", extend("force", opt, { desc = "Save Current Buffer" }))

-- For tabs
map("n", "<M-1>", "1gt", extend("force", opt, { desc = "Gota 1st tab" }))
map("n", "<M-2>", "2gt", extend("force", opt, { desc = "Gota 2st tab" }))
map("n", "<M-3>", "3gt", extend("force", opt, { desc = "Gota 3st tab" }))
