local M = {}
local get_highlight = vim.api.nvim_get_hl
local set_highlight = vim.api.nvim_set_hl

function M.statusline_highlight()
  local colors = {
    stl = get_highlight(0, { name = "Keyword" }),
    stl_insert = get_highlight(0, { name = "Function" }),
    stl_visual = get_highlight(0, { name = "@attribute", link = false }),
    stl_replace = get_highlight(0, { name = "Float" }),
    stl_terminal = get_highlight(0, { name = "Conditional" }),
    stl_cmd = get_highlight(0, { name = "Boolean" }),
  }

  set_highlight(0, "StatusLineAccent", { fg = colors.stl.fg, bg = colors.stl.bg, bold = true })
  set_highlight(0, "StatusLineInsertAccent", { fg = colors.stl_insert.fg, bg = colors.stl_insert.bg, bold = true })
  set_highlight(0, "StatusLineVisualAccent", { fg = colors.stl_visual.fg, bg = colors.stl_visual.bg, bold = true })
  set_highlight(0, "StatusLineReplaceAccent", { fg = colors.stl_replace.fg, bg = colors.stl_replace.bg, bold = true })
  set_highlight(
    0,
    "StatusLineTerminalAccent",
    { fg = colors.stl_terminal.fg, bg = colors.stl_terminal.bg, bold = true }
  )
  set_highlight(0, "StatusLineCmdLineAccent", { fg = colors.stl_cmd.fg, bg = colors.stl_cmd.bg, bold = true })
end

return M
