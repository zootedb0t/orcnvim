local M = {}
local get_highlight = vim.api.nvim_get_hl
local highlight = vim.api.nvim_set_hl

local colors = {
  stl = get_highlight(0, { name = "Keyword" }),
  stl_insert = get_highlight(0, { name = "Function" }),
  stl_visual = get_highlight(0, { name = "@attribute", link = false }),
  stl_replace = get_highlight(0, { name = "Float" }),
  stl_terminal = get_highlight(0, { name = "Conditional" }),
  stl_cmd = get_highlight(0, { name = "Boolean" }),
}

function M.statusline_highlight()
  highlight(0, "StatusLineAccent", { fg = colors.stl.fg, bg = colors.stl.bg, bold = true })
  highlight(0, "StatusLineInsertAccent", { fg = colors.stl_insert.fg, bg = colors.stl_insert.bg, bold = true })
  highlight(0, "StatusLineVisualAccent", { fg = colors.stl_visual.fg, bg = colors.stl_visual.bg, bold = true })
  highlight(0, "StatusLineReplaceAccent", { fg = colors.stl_replace.fg, bg = colors.stl_replace.bg, bold = true })
  highlight(0, "StatusLineTerminalAccent", { fg = colors.stl_terminal.fg, bg = colors.stl_terminal.bg, bold = true })
  highlight(0, "StatusLineCmdLineAccent", { fg = colors.stl_cmd.fg, bg = colors.stl_cmd.bg, bold = true })
  highlight(0, "StatuslineTransparent", {}) -- Some colorscheme were drawing empty statusline for floating window like telescope, lazy. This fixes that
  highlight(0, "StatusLineOthers", { link = "Type" })
  highlight(0, "StatusLineGit", { link = "Constant" })
  highlight(0, "StatusLineGitAdd", { link = "GitSignsAdd" })
  highlight(0, "StatusLineGitChange", { link = "GitSignsChange" })
  highlight(0, "StatusLineGitRemove", { link = "GitSignsDelete" })
  highlight(0, "StatusLineInfo", { link = "@character.special" })
  highlight(0, "StatusLinePackage", { link = "Constant" })
  highlight(0, "StatusLineLsp", { link = "Conditional" })
end

return M
