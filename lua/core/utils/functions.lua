local M = {}

function M.isempty(s)
  return s == nil or s == 0 or s == ""
end

function M.ismatch(table, value)
  for key, _ in pairs(table) do
    if table[key] == value then
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
  local file_icon = devicons.get_icon(filename, extension, { default = true })
  if M.isempty(file_icon) then
    return ""
  end
  return file_icon
end

return M
