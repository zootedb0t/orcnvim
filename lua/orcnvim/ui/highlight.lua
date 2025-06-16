local M = {}
local get_highlight = vim.api.nvim_get_hl
local set_highlight = vim.api.nvim_set_hl

function M.statusline_highlight()
  local hl_mappings = {
    StatusLineAccent = "Function",
    StatusLineInsertAccent = "Keyword",
    StatusLineVisualAccent = "Constant",
    StatusLineReplaceAccent = "WarningMsg",
    StatusLineTerminalAccent = "Conditional",
    StatusLineCmdLineAccent = "Boolean",
  }
  for target_hl, source_hl in pairs(hl_mappings) do
    local color = get_highlight(0, { name = source_hl })
    if color then
      set_highlight(0, target_hl, {
        fg = color.fg,
        bg = color.bg,
        bold = true,
      })
    end
  end
end

return M
