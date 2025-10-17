local M = {}

local is_match = require("orcnvim.utils").ismatch
-- Add filetypes to the list for which you don't want statuscolumn before unpack statement
local disable_statuscolumn = {
  "TelescopePrompt",
  "lazy",
  "NvimTree",
  "help",
  "netrw",
  "qf",
  unpack(require("orcnvim.utils").disable()),
}

local function stc()
  if vim.v.virtnum ~= 0 then
    return ""
  end

  local sign = vim.opt.signcolumn:get() == "yes" and "%s" or ""
  local num_enabled = vim.opt.number:get() or vim.opt.relativenumber:get()
  local num = num_enabled and "%=%l " or ""

  return sign .. num
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
