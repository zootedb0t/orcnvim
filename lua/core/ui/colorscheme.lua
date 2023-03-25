-- For colorscheme that don't support transparency. Set transparent_nvim value in options.lua.
if vim.g.transparent_nvim then
  require("core.autocmd").enable_tranparency()
end

-- catppuccin theme
-- require("catppuccin").setup({
--   flavour = "mocha", -- latte, frappe, macchiato, mocha
--   background = { -- :h background
--     light = "latte",
--     dark = "mocha",
--   },
--   transparent_background = true,
--   term_colors = true,
-- })

-- Setting colorscheme
-- vim.cmd("colorscheme nightfly")
vim.cmd("colorscheme moonfly")
-- vim.cmd("colorscheme catppuccin")
