local highlight = vim.api.nvim_set_hl
local mocha = require("catppuccin.palettes").get_palette("mocha")

highlight(0, "StatusLineAccent", { fg = mocha.surface0, bg = mocha.green })
highlight(0, "StatuslineInsertAccent", { fg = mocha.surface0, bg = mocha.mauve })
highlight(0, "StatuslineVisualAccent", { fg = mocha.surface0, bg = mocha.red })
highlight(0, "StatuslineReplaceAccent", { fg = mocha.surface0, bg = mocha.blue })
highlight(0, "StatuslineTerminalAccent", { fg = mocha.surface0, bg = mocha.yellow })
highlight(0, "StatuslineCmdLineAccent", { fg = mocha.surface0, bg = mocha.sapphire })
