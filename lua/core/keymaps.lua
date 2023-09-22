local map = vim.keymap.set
vim.g.maplocalleader = ","

map("n", "<ESC>", "<CMD>noh<CR>") -- Remove highlights from search result

-- map("n", "<BS>", "<C-^>zz", { desc = "Jump to last Buffer" }, opt) -- Jump to last buffer

-- Remove annoying exmode
map("n", "Q", "<Nop>")
map("n", "q:", "<Nop>")

-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Check for line wrapping" })

map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Check for line wrapping" })

map("n", "H", "^", { desc = "goto beginning of line" })
map("n", "L", "$", { desc = "goto end of line" })

-- resizing window with <ctrl> and arrow
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Better Window Navigation using <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window " })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window " })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window " })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window " })

-- better indenting
map("v", "<", "<gv", { desc = "Indent Left" })
map("v", ">", ">gv", { desc = "Indent Right" })

-- Replace selected text without yanking it
map("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Move line(s) up and down
map("n", "<M-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<M-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("v", "<M-j>", ":m '>+1<CR>==gv=gv", { desc = "Move line down" })
map("v", "<M-k>", ":m '<-2<CR>==gv=gv", { desc = "Move line up" })

-- Move selected line / block of text in visual mode
map("x", "K", ":move '<-2<CR>gv-gv", { desc = "Move selected visual line up" })
map("x", "J", ":move '>+1<CR>gv-gv", { desc = "Move selected visual line down" })

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

-- Save Buffer
map({ "i", "n" }, "<C-s>", "<cmd>w<cr>", { desc = "Save Current Buffer" })

-- Jump between tabs
map("n", "<M-1>", "1gt", { desc = "Gota 1st tab" })
map("n", "<M-2>", "2gt", { desc = "Gota 2st tab" })
map("n", "<M-3>", "3gt", { desc = "Gota 3st tab" })
