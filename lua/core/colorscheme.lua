-- Set true to make window transparent
local transparent_window = false


-- vim.g.nightflyWinSeparator = 2
-- vim.g.nightflyTransparent = true

-- require("catppuccin").setup({
--   flavour = "mocha", -- latte, frappe, macchiato, mocha
--   background = { -- :h background
--     light = "latte",
--     dark = "macchiato",
--   },
--   transparent_background = true,
--   term_colors = true,
-- })

if transparent_window then
  require("core.autocmd").enable_tranparency()
end

require("rose-pine").setup()
vim.cmd("colorscheme rose-pine")

