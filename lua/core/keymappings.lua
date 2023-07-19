local map = vim.keymap.set
local opt = { noremap = true, silent = true }
vim.g.maplocalleader = ","

map("n", "<ESC>", "<CMD>noh<CR>", opt) -- Remove highlights from search result

-- map("n", "<BS>", "<C-^>zz", { desc = "Jump to last Buffer" }, opt) -- Jump to last buffer

-- Remove annoying exmode
map("n", "Q", "<Nop>", opt)
map("n", "q:", "<Nop>", opt)

-- Remap for dealing with word wrap
map(
  "n",
  "k",
  "v:count == 0 ? 'gk' : 'k'",
  vim.tbl_extend("force", opt, { expr = true, desc = "Check for line wrapping" })
)

map(
  "n",
  "j",
  "v:count == 0 ? 'gj' : 'j'",
  vim.tbl_extend("force", opt, { expr = true, desc = "Check for line wrapping" })
)

map("n", "H", "^", { desc = "goto beginning of line" }, opt)
map("n", "L", "$", { desc = "goto end of line" }, opt)

-- resizing window with <ctrl> and arrow
map("n", "<C-Up>", "<cmd>resize +2<cr>", opt, { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", opt, { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", opt, { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", opt, { desc = "Increase window width" })

-- Better Window Navigation using <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", opt, { desc = "Go to left window " })
map("n", "<C-j>", "<C-w>j", opt, { desc = "Go to lower window " })
map("n", "<C-k>", "<C-w>k", opt, { desc = "Go to upper window " })
map("n", "<C-l>", "<C-w>l", opt, { desc = "Go to right window " })

-- better indenting
map("v", "<", "<gv", opt, { desc = "Indent Left" })
map("v", ">", ">gv", opt, { desc = "Indent Right" })

-- Replace selected text without yanking it
map("v", "p", '"_dP', opt, { desc = "Paste without yanking" })
map("v", "P", '"_dp', opt, { desc = "Paste without yanking" })

-- Move line(s) up and down
map("n", "<M-j>", ":m .+1<CR>==", opt, { desc = "Move line down" })
map("n", "<M-k>", ":m .-2<CR>==", opt, { desc = "Move line up" })
map("v", "<M-j>", ":m '>+1<CR>==gv=gv", opt, { desc = "Move line down" })
map("v", "<M-k>", ":m '<-2<CR>==gv=gv", opt, { desc = "Move line up" })

-- Move selected line / block of text in visual mode
map("x", "K", ":move '<-2<CR>gv-gv", opt)
map("x", "J", ":move '>+1<CR>gv-gv", opt)

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
map("n", "<localleader>d", vim.diagnostic.open_float, opt)
map("n", "[d", vim.diagnostic.goto_prev, opt)
map("n", "]d", vim.diagnostic.goto_next, opt)
map("n", "<localleader>q", vim.diagnostic.setloclist, opt)

map({ "i", "n" }, "<C-s>", "<cmd>w<cr>", opt, { desc = "Save Current Buffer" })
