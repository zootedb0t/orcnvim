-- NightFly theme
vim.g.nightflyWinSeparator = 2
vim.g.nightflyTransparent = false

-- catppuccin theme
-- require("catppuccin").setup({
--   flavour = "mocha", -- latte, frappe, macchiato, mocha
--   background = { -- :h background
--     light = "latte",
--     dark = "macchiato",
--   },
--   transparent_background = true,
--   term_colors = true,
-- })

-- Setting colorscheme

-- set transparent_nvim value in options.lua
if vim.g.transparent_nvim then
  require("core.autocmd").enable_tranparency()
end

vim.cmd("colorscheme nightfly")
