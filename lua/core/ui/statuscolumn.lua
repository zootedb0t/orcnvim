local M = {}

require("core.ui.highlight").str_highlight()
local is_match = require("core.utils.functions").ismatch
local disable_statuscolumn =
  { "alpha", "toggleterm", "NvimTree", "WhichKey", "TelescopePrompt", "TelescopeResults", "lazy", "help", "" }

function M.statuscolumn()
  local buffer_type = vim.api.nvim_buf_get_option(0, "ft")
  if is_match(disable_statuscolumn, buffer_type) then
    return ""
  else
    return "%#Column#" .. '%=%{v:relnum ? v:relnum : v:lnum}%=%{%&signcolumn ? " " : "%s" %}'
  end
end

return M
