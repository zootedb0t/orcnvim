local M = {}
function M.config()
  local status_ok, tab = pcall(require, "tabby.tabline")
  if status_ok then
    tab.use_preset("tab_only", {
      theme = {
        fill = "TabLineFill", -- tabline background
        head = "TabLine", -- head element highlight
        current_tab = "TabLineSel", -- current tab label highlight
        tab = "TabLine", -- other tab label highlight
        win = "TabLine", -- window highlight
        tail = "TabLine", -- tail element highlight
      },
      nerdfont = true, -- whether use nerdfont
      buf_name = {
        mode = "tail",
      },
    })
  end
end

return M
