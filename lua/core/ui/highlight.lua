local M = {}
local highlight = vim.api.nvim_set_hl

function M.statusline_highlight()
  highlight(0, "StatusLineAccent", { fg = "#313244", bg = "#A6E3A1" })
  highlight(0, "StatuslineInsertAccent", { fg = "#313244", bg = "#CBA6F7" })
  highlight(0, "StatuslineVisualAccent", { fg = "#313244", bg = "#F38BA8" })
  highlight(0, "StatuslineReplaceAccent", { fg = "#313244", bg = "#89B4FA" })
  highlight(0, "StatuslineTerminalAccent", { fg = "#313244", bg = "#F9E2AF" })
  highlight(0, "StatuslineCmdLineAccent", { fg = "#313244", bg = "#74C7EC" })
  -- Some colorscheme(like rose-pine) were drawing empty statusline for floating window like telescope, lazy. This fixes that
  highlight(0, "StatuslineTransparent", { fg = "NONE", bg = "NONE" })
  highlight(0, "ScrollBar", { fg = "#A6E3A1" })
end

M.winbar_highlight = function()
  highlight(0, "WinbarFile", { fg = "#A6E3A1" })
  highlight(0, "NavicSeparator", { fg = "#89B4FA" })
end

return M
