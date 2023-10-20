local M = {}

local is_match = require("core.utils").ismatch
-- Add filetypes to the list for which you don't want statuscolumn before unpack statement
local disable_statuscolumn = {
  "TelescopePrompt",
  "lazy",
  "NvimTree",
  "help",
  "netrw",
  unpack(require("core.utils").disable()),
}

local function stc()
  local component = {}
  local num_status, relnum_status = vim.opt.number:get(), vim.opt.relativenumber:get()
  local signcolumn_status = vim.opt.signcolumn:get()
  if signcolumn_status == "yes" then
    component[1] = "%s"
  else
    component[1] = ""
  end

  if vim.v.virtnum == 0 then
    if vim.v.relnum == 0 then
      component[2] = num_status and "%l" .. " "
    else
      component[2] = relnum_status and "%r" .. " " or "%l" .. " "
    end
  end

  return table.concat(component, "")
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
