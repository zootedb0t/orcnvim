local M = {}

require("core.ui.highlight").str_highlight()
local is_match = require("core.utils.functions").ismatch
local disable_statuscolumn = {
  "alpha",
  "toggleterm",
  "NvimTree",
  "WhichKey",
  "TelescopePrompt",
  "TelescopeResults",
  "lazy",
  "help",
  "mason",
  "netrw",
  "",
}

-- TODO Convert return into more readable statement
local function stc()
  -- local lnum, rnum= vim.v.lnum, vim.v.relnum
  local num, relnum = vim.opt.number:get(), vim.opt.relativenumber:get()
  if num and relnum then
    return '%{%&signcolumn ? " " : "%s" %}%=%{v:relnum ? v:relnum : v:lnum} '
  elseif num and not relnum then
    return '%{%&signcolumn ? " " : "%s" %}%=%{v:lnum} '
  end
end

function M.draw()
  --local buffer_type = vim.api.nvim_get_option_value({"filetype"}, {0})
  local buffer_type = vim.bo.filetype
  if is_match(disable_statuscolumn, buffer_type) then
    return ""
  else
    return stc()
  end
end

return M
