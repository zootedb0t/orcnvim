local M = {}

function M.isempty(s)
  return s == nil or s == 0 or s == ""
end

function M.ismatch(table, value)
  for _, val in ipairs(table) do
    if val == value then
      return true
    end
  end
end

function M.get_icons(filename, extension)
  local status_ok, devicons = pcall(require, "nvim-web-devicons")
  if not status_ok then
    vim.notify("nvim-web-devicons is not installed")
    return ""
  end
  local file_icon, color = devicons.get_icon_color(filename, extension, { default = true })
  if M.isempty(file_icon) and M.isempty(color) then
    return ""
  end
  return { icon = file_icon, highlight = color }
end

function M.disable()
  return {
    "alpha",
    "toggleterm",
  }
end

return M
