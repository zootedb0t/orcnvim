local M = {}

-- "%=%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . '  ' : v:lnum) : ''}%=%s",
local is_match = require("core.utils.functions").ismatch
local disable_statuscolumn =
  { "alpha", "toggleterm", "NvimTree", "WhichKey", "TelescopePrompt", "TelescopeResults", "" }

function M.statuscolumn()
  local buffer_type = vim.api.nvim_buf_get_option(0, "ft")
  if is_match(disable_statuscolumn, buffer_type) then
    return ""
  else
    return "%{v:relnum?v:relnum:v:lnum}"
  end
end

return M
