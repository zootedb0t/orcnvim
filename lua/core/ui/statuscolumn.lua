local M = {}

require("core.ui.highlight").str_highlight()
local is_match = require("core.utils.functions").ismatch
-- Add filetypes to the list for which you don't want statuscolumn before unpack statement
local disable_statuscolumn = {
  "TelescopePrompt",
  "lazy",
  "NvimTree",
  "help",
  "netrw",
  unpack(require("core.utils.functions").disable()),
}

-- TODO Convert return into more readable statement
local function stc()
  local num, relnum = vim.opt.number:get(), vim.opt.relativenumber:get()
  if num and relnum then
    return '%{%&signcolumn ? " " : "%s" %}%=%{v:relnum ? v:relnum : v:lnum} '
  elseif num and not relnum then
    return '%{%&signcolumn ? " " : "%s" %}%=%{v:lnum} '
  end
end

function M.draw()
  local buffer_type = vim.bo.filetype
  if is_match(disable_statuscolumn, buffer_type) then
    return ""
  else
    return stc()
  end
end

return M
