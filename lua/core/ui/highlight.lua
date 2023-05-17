local M = {}
local highlight = vim.api.nvim_set_hl
local get_highlight = vim.api.nvim_get_hl_by_name

-- No need to hardcode colors
local colors = {
  stl = get_highlight("Keyword", true),
  stl_insert = get_highlight("Function", true),
  stl_visual = get_highlight("@attribute", true),
  stl_replace = get_highlight("Float", true),
  stl_terminal = get_highlight("Conditional", true),
  stl_cmd = get_highlight("Boolean", true),
}

function M.statusline_highlight()
  highlight(0, "StatusLineAccent", { fg = colors.stl.foreground, bg = colors.stl.background, bold = true })
  highlight(
    0,
    "StatuslineInsertAccent",
    { fg = colors.stl_insert.foreground, bg = colors.stl_insert.background, bold = true }
  )
  highlight(
    0,
    "StatuslineVisualAccent",
    { fg = colors.stl_visual.foreground, bg = colors.stl_visual.background, bold = true }
  )
  highlight(
    0,
    "StatuslineReplaceAccent",
    { fg = colors.stl_replace.foreground, bg = colors.stl_replace.background, bold = true }
  )
  highlight(
    0,
    "StatuslineTerminalAccent",
    { fg = colors.stl_terminal.foreground, bg = colors.stl_terminal.background, bold = true }
  )
  highlight(
    0,
    "StatuslineCmdLineAccent",
    { fg = colors.stl_cmd.foreground, bg = colors.stl_cmd.background, bold = true }
  )
  highlight(0, "StatuslineTransparent", {}) -- Some colorscheme were drawing empty statusline for floating window like telescope, lazy. This fixes that
  highlight(0, "StatusLineOthers", { link = "Type" })
  highlight(0, "StatusLineGit", { link = "Constant" })
  highlight(0, "StatusLineGitAdd", { link = "GitSignsAdd" })
  highlight(0, "StatusLineGitChange", { link = "GitSignsChange" })
  highlight(0, "StatusLineGitRemove", { link = "GitSignsDelete" })
  highlight(0, "StatusLineInfo", { link = "Character" })
  highlight(0, "StatusLinePackage", { link = "Constant" })
  highlight(0, "StatusLineLsp", { link = "Identifier" })
end

M.winbar_highlight = function()
  highlight(0, "WinbarFile", { link = "Identifier" })
  highlight(0, "WinBarNC", {})
  highlight(0, "WinBar", {})
  highlight(0, "NavicSeparator", { link = "Type" })
  highlight(0, "NavicIconsFile", { link = "Identifier" })
  highlight(0, "NavicIconsModule", { link = "Conditional" })
  highlight(0, "NavicIconsNamespace", { link = "@namespace" })
  highlight(0, "NavicIconsPackage", { link = "Type" })
  highlight(0, "NavicIconsClass", { link = "@type" })
  highlight(0, "NavicIconsMethod", { link = "Function" })
  highlight(0, "NavicIconsProperty", { link = "@property" })
  highlight(0, "NavicIconsField", { link = "Identifier" })
  highlight(0, "NavicIconsConstructor", { link = "@constructor" })
  highlight(0, "NavicIconsEnum", { link = "@type" })
  highlight(0, "NavicIconsInterface", { link = "@type" })
  highlight(0, "NavicIconsFunction", { link = "Function" })
  highlight(0, "NavicIconsVariable", { link = "@variable" })
  highlight(0, "NavicIconsConstant", { link = "Constant" })
  highlight(0, "NavicIconsString", { link = "String" })
  highlight(0, "NavicIconsNumber", { link = "Constant" })
  highlight(0, "NavicIconsBoolean", { link = "Boolean" })
  highlight(0, "NavicIconsArray", { link = "Type" })
  highlight(0, "NavicIconsObject", { link = "@property" })
  highlight(0, "NavicIconsEnumMember", { link = "@type" })
  highlight(0, "NavicIconsStruct", { link = "@type" })
  highlight(0, "NavicIconsEvent", { link = "@exception" })
  highlight(0, "NavicIconsOperator", { link = "Operator" })
  highlight(0, "NavicIconsTypeParameter", { link = "@parameter" })
  highlight(0, "NavicText", { link = "@variable" })
end

M.bufferline = function()
  highlight(0, "BufferVisible", {})
  highlight(0, "BufferVisibleIndex", {})
  highlight(0, "BufferVisibleMod", {})
  highlight(0, "BufferVisibleSign", {})
  highlight(0, "BufferVisibleTarget", {})
  highlight(0, "BufferInactiveIndex", {})
  highlight(0, "BufferInactiveMod", {})
  highlight(0, "BufferInactiveTarget", {})
  highlight(0, "BufferTabpages", {})
  highlight(0, "BufferTabpageFill", {})
  highlight(0, "BufferCurrent", {})
  highlight(0, "BufferCurrentMod", { fg = "#FB4934" })
  highlight(0, "BufferCurrentSign", { fg = "#A6E3A1" })
  highlight(0, "BufferInactive", {})
  highlight(0, "BufferInactiveSign", {})
  highlight(0, "BufferInactiveIcon", {})
  highlight(0, "BufferCurrentIcon", {})
  highlight(0, "BufferVisibleIcon", {})
  highlight(0, "BufferAlternateIcon", {})
  highlight(0, "BufferDefaultCurrentIcon", {})
  highlight(0, "BufferDefaultInactiveIcon", {})
  highlight(0, "BufferDefaultVisible", {})
end

M.cmp_highlight = function()
  highlight(0, "CmpItemMenu", { link = "Type" })
end

M.str_highlight = function()
  highlight(0, "Column", { link = "Constant" })
end

M.alpha = function ()
  highlight(0, "AlphaHeader", { link = "Constant" })
  highlight(0, "AlphaShortcut", { link = "Type" })
  highlight(0, "AlphaFooter", { link = "Function" })
end

return M
