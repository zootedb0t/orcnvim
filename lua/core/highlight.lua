local highlight = vim.api.nvim_set_hl
local rose = require("rose-pine.palette")
-- local mocha = require("catppuccin.palettes").get_palette("mocha")

highlight(0, "StatusLineAccent", { fg = rose.base, bg = rose.foam })
highlight(0, "StatuslineInsertAccent", { fg = rose.base, bg = rose.love })
highlight(0, "StatuslineVisualAccent", { fg = rose.base, bg = rose.iris })
highlight(0, "StatuslineReplaceAccent", { fg = rose.base, bg = rose.rose })
highlight(0, "StatuslineTerminalAccent", { fg = rose.base, bg = rose.pine })
highlight(0, "StatuslineCmdLineAccent", { fg = rose.base, bg = rose.gold })
