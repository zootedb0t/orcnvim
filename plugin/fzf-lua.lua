local fzf_loaded = false

local function fzf(picker)
  return function()
    if not fzf_loaded then
      vim.pack.add({
        "https://github.com/DaikyXendo/nvim-material-icon",
        "https://github.com/ibhagwan/fzf-lua",
      })
      require("fzf-lua").setup({
        winopts = {
          height = 0.6,
          -- width = 0.55,
          preview = {
            scrollbar = false,
          },
        },
      })
      fzf_loaded = true
    end
    require("fzf-lua")[picker]()
  end
end

vim.keymap.set("n", "<leader>sf", fzf("files"), { desc = "Find Files" })
vim.keymap.set("n", "<leader>ls", fzf("lsp_workspace_symbols"), { desc = "Workspace symbols" })
vim.keymap.set("n", "<leader>sb", fzf("git_branches"), { desc = "Checkout branch" })
vim.keymap.set("n", "<leader>sc", fzf("commands"), { desc = "Search commands" })
vim.keymap.set("n", "<leader>sg", fzf("live_grep"), { desc = "Grep in CWD" })
vim.keymap.set("n", "<leader>sh", fzf("helptags"), { desc = "Find Help Tags" })
vim.keymap.set("n", "<leader>sk", fzf("keymaps"), { desc = "Search keymaps" })
vim.keymap.set("n", "<leader>sr", fzf("oldfiles"), { desc = "Search Recent Files" })
vim.keymap.set("n", "<leader>b", fzf("buffers"), { desc = "Show buffers" })
