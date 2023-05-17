-- Setting colorscheme

require("fluoromachine").setup({
  glow = false,
  theme = "fluoromachine", -- Choose between retrowave, fluoromachine
  brightness = 0.04,
  transparent = "full",
})

vim.cmd("colorscheme fluoromachine")
-- vim.cmd("colorscheme onedark")
-- vim.cmd("colorscheme horizon")

-- Moonfly options
-- vim.g.moonflyTransparent = true
-- vim.g.moonflyUnderlineMatchParen = true
-- vim.cmd("colorscheme moonfly")
