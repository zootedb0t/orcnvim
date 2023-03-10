local map = vim.keymap.set
local opt = { silent = true }
vim.g.maplocalleader = ","

map("n", "<ESC>", "<CMD>noh<CR>", opt) -- Remove highlights from search result

-- map("n", "<BS>", "<C-^>zz", { desc = "Jump to last Buffer" }, opt) -- Jump to last buffer

-- Remove annoying exmode
map("n", "Q", "<Nop>", opt)
map("n", "q:", "<Nop>", opt)

-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

map("n", "H", "^", { desc = "Goto Beginning of line" }, opt)
map("n", "L", "$", { desc = "Goto End of line" }, opt)

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
map("v", "<", "<gv", { desc = "Indent Left" }, opt)
map("v", ">", ">gv", { desc = "Indent Right" }, opt)

-- Replace selected text without yanking it
map("v", "p", '"_dP', { desc = "Paste without yanking" }, opt)
map("v", "P", '"_dp', { desc = "Paste without yanking" }, opt)

-- Move line(s) up and down
map("n", "<M-j>", ":m .+1<CR>==", { silent = true, desc = "Bubble line down" }, opt)
map("n", "<M-k>", ":m .-2<CR>==", { silent = true, desc = "Bubble line up" }, opt)
map("v", "<M-j>", ":m '>+1<CR>==gv=gv", { silent = true, desc = "Bubble line down" }, opt)
map("v", "<M-k>", ":m '<-2<CR>==gv=gv", { silent = true, desc = "Bubble line up" }, opt)

-- Move selected line / block of text in visual mode
map("x", "K", ":move '<-2<CR>gv-gv", opt)
map("x", "J", ":move '>+1<CR>gv-gv", opt)

-- navigate within insert mode
-- map("i", "<C-h>", "<Left>") -- " ???  move left"
-- map("i", "<C-l>", "<Right>") -- "??? move right"
-- map("i", "<C-j>", "<Down>") -- "??? move down"
-- map("i", "<C-k>", "<Up>") -- "??? move up" },

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

-- Tabline
-- map("n", "<Leader>tn", "<CMD>tabnew<CR>", { desc = "New Tab" })
-- map("n", "<Leader>tc", "<CMD>tabclose<CR>", { desc = "Change Tab Name" })
