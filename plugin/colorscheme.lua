vim.pack.add({ "https://github.com/zootedb0t/citruszest.nvim" })

require("citruszest").setup({
  option = {
    transparent = true,
    bold = true,
  },
  style = {
    TabLine = { fg = "#BFBFBF", bg = "NONE" }, -- tab pages line, not active tab page label
    TabLineSel = { fg = "#FFAA54", bg = "NONE" }, -- tab pages line, active tab page label
  },
})

vim.cmd("colorscheme citruszest")
