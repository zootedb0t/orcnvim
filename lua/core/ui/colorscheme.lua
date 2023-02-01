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

-- Ayu theme
-- local colors = require('ayu.colors')
-- colors.generate()

-- require("ayu").setup({
--   mirage = false,
--   overrides = {
--     LineNr = { fg = colors.fg },
--   },
-- })

-- set transparent_nvim value in options.lua
if vim.g.transparent_nvim then
  require("core.autocmd").enable_tranparency()
end

-- Setting colorscheme
vim.cmd("colorscheme nightfly")
