local M = {}

-- 's' is not table, if table use 'vim.tbl_isempty()' instead
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
    vim.notify("Can't find icon or color")
    return ""
  end
  return { icon = file_icon, highlight = color }
end

function M.disable()
  return {
    "alpha",
    "toggleterm",
    "mason",
    "",
  }
end

-- Toggle statusline
function M.toggle_statusline()
  local statusline = vim.opt.laststatus:get() -- : is used to pass self as first-parameter
  if statusline == 3 then
    vim.opt.laststatus = 0
  elseif statusline == 0 then
    vim.opt.laststatus = 3
  end
end

-- Qucikfix window
function M.quickfix_toggle()
  local windows = vim.fn.getwininfo()
  for i = 1, vim.tbl_count(windows) do
    local tbl = windows[i]
    if tbl.quickfix == 1 then
      vim.cmd("cclose")
    else
      vim.cmd("horizontal botright copen") -- Open quickfix window horizontally
    end
  end
end

--- Change the number column between relative and fixed
function M.toggle_number()
  local number = vim.wo.number -- local to window
  local relativenumber = vim.wo.relativenumber -- local to window
  if number and relativenumber then
    vim.wo.relativenumber = false
  elseif number then
    vim.wo.relativenumber = true
  end
end

-- Change directory
function M.change_root_directory()
  vim.cmd([[lcd%:p:h]])
  vim.notify("Directory changed")
end

-- Enable lsp for only these filetypes
function M.lsp_filetype()
  return {
    "c",
    "cpp",
    "css",
    "haskell",
    "html",
    "javascript",
    "lua",
    "python",
    "typescript",
  }
end

-- Enable linting for only these filetypes
function M.lint_filetype()
  return { "python", "sh", "javascript", "typescript", "htmldjango" }
end

function M.inlay_hint()
  if vim.lsp.inlay_hint.is_enabled(0) then
    vim.lsp.inlay_hint.enable(0, false)
  else
    vim.lsp.inlay_hint.enable(0, true)
  end
end

return M
