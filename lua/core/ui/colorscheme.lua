-- Setting colorscheme

require("fluoromachine").setup({
  glow = true,
  theme = "fluoromachine", -- Choose between retrowave, fluoromachine
  brightness = 0.04,
  transparent = "full",
})

vim.cmd("colorscheme fluoromachine")

-- Moonfly options
-- vim.g.moonflyTransparent = true
-- vim.g.moonflyUnderlineMatchParen = true
-- vim.cmd("colorscheme moonfly")
