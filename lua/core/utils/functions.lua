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

return M
