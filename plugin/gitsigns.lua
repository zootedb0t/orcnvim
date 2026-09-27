local function load_gitsigns()
  vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
  require("gitsigns").setup({})
end

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  once = true,
  callback = load_gitsigns,
})
