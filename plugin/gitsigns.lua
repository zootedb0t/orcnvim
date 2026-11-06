local function load_gitsigns()
  vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
  require("gitsigns").setup({})
end

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  once = true,
  callback = load_gitsigns,
})

-- Keymaps
local map = vim.keymap.set
map("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Show inline blame" })
map("n", "<leader>gc", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview current hunk" })
map("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", { desc = "Current buffer diff" })
map("n", "<leader>gn", "<cmd>Gitsigns next_hunk<cr>", { desc = "Show next hunk" })
map("n", "<leader>gp", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Show prvious hunk" })
map("n", "<leader>gq", "<cmd>Gitsigns setqflist<cr>", { desc = "Show quickfix list" })
