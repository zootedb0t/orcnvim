local M = {}

local devicon = require("orcnvim.utils").get_icons

function M.click(buf, clicks, button)
  if button == "l" then
    vim.api.nvim_set_current_buf(buf)
  elseif button == "m" then
    pcall(vim.api.nvim_buf_delete, buf, {})
  end
end

function M.render()
  -- highlights()

  local current = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()
  local result = {}

  for _, buf in ipairs(buffers) do
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
      local name = vim.api.nvim_buf_get_name(buf)
      local extension = vim.fn.fnamemodify(name, ":e")
      local filename = name ~= "" and vim.fn.fnamemodify(name, ":t") or "[No Name]"

      -- For icons
      local icon_data = devicon(name, extension)
      local file_icon = icon_data and icon_data.icon or "󰈔"

      local selected = buf == current
      local modified = vim.bo[buf].modified

      local hl = selected and "TabLineSel" or "TabLine"

      table.insert(
        result,
        "%"
          .. buf
          .. "@v:lua.require'orcnvim.ui.tabline'.click@"
          .. "%#"
          .. hl
          .. "#"
          .. "  "
          .. file_icon
          .. " "
          .. filename
          .. (modified and " %#" .. hl .. "#●" or "")
          .. "  %T"
      )
    end
  end

  return table.concat(result) .. "%#TabLineFill#%="
end

return M
