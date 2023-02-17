local M = {}
local highlight = vim.api.nvim_set_hl

function M.statusline_highlight()
  highlight(0, "StatusLineAccent", { fg = "#313244", bg = "#A6E3A1", bold = true })
  highlight(0, "StatuslineInsertAccent", { fg = "#313244", bg = "#FF8F40", bold = true })
  highlight(0, "StatuslineVisualAccent", { fg = "#313244", bg = "#D96C75", bold = true })
  highlight(0, "StatuslineReplaceAccent", { fg = "#313244", bg = "#89B4FA", bold = true })
  highlight(0, "StatuslineTerminalAccent", { fg = "#313244", bg = "#FB4934", bold = true })
  highlight(0, "StatuslineCmdLineAccent", { fg = "#313244", bg = "#89B4FA", bold = true })
  -- Some colorscheme(like rose-pine) were drawing empty statusline for floating window like telescope, lazy. This fixes that
  highlight(0, "StatuslineTransparent", {})
  highlight(0, "ScrollBar", { fg = "#A6E3A1" })
end

M.winbar_highlight = function()
  highlight(0, "WinbarFile", { fg = "#A6E3A1", bg = "NONE", bold = true })
  highlight(0, "WinBarNC", {})
  highlight(0, "WinBar", {})
  highlight(0, "NavicSeparator", { fg = "#89B4FA", bg = "NONE" })
  highlight(0, "NavicIconsFile", { fg = "#89B4FA" })
  highlight(0, "NavicIconsModule", { fg = "#89B4FA" })
  highlight(0, "NavicIconsNamespace", { fg = "#89B4FA" })
  highlight(0, "NavicIconsPackage", { fg = "#89B4FA" })
  highlight(0, "NavicIconsClass", { fg = "#F9E2AF" })
  highlight(0, "NavicIconsMethod", { fg = "#89B4FA" })
  highlight(0, "NavicIconsProperty", { fg = "#A6E3A1" })
  highlight(0, "NavicIconsField", { fg = "#A6E3A1" })
  highlight(0, "NavicIconsConstructor", { fg = "#89B4FA" })
  highlight(0, "NavicIconsEnum", { fg = "#A6E3A1" })
  highlight(0, "NavicIconsInterface", { fg = "#F9E2AF" })
  highlight(0, "NavicIconsFunction", { fg = "#A6E3A1" })
  highlight(0, "NavicIconsVariable", { fg = "#F2CDCD" })
  highlight(0, "NavicIconsConstant", { fg = "#FAB387" })
  highlight(0, "NavicIconsString", { fg = "#A6E3A1" })
  highlight(0, "NavicIconsNumber", { fg = "#FAB387" })
  highlight(0, "NavicIconsBoolean", { fg = "#FAB387" })
  highlight(0, "NavicIconsArray", { fg = "#A6E3A1" })
  highlight(0, "NavicIconsObject", { fg = "#A6E3A1" })
  highlight(0, "NavicIconsEnumMember", { fg = "#F38BA8" })
  highlight(0, "NavicIconsStruct", { fg = "#A6E3A1" })
  highlight(0, "NavicIconsEvent", { fg = "#A6E3A1" })
  highlight(0, "NavicIconsOperator", { fg = "#A6E3A1" })
  highlight(0, "NavicIconsTypeParameter", { fg = "#A6E3A1" })
  highlight(0, "NavicText", { fg = "#CDD6F4" })
end

M.cmp_highlight = function()
  highlight(0, "CmpItemMenu", { fg = "#296596" })
end

return M
