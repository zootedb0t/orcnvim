local M = {}

local devicons_ok, devicons = pcall(require, "nvim-web-devicons")
if not devicons_ok then
  return vim.notify("nvim-web-devicons is not installed", vim.log.levels.WARN)
end

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
  if not devicons then
    return ""
  end

  local file_icon, color = devicons.get_icon_color(filename, extension, { default = true })
  if not file_icon or file_icon == "" then
    return ""
  end
  local hl_group = "FileIcon"
  vim.api.nvim_set_hl(0, "FileIcon", { fg = color })
  return { icon = file_icon, highlight = hl_group }
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
  vim.o.laststatus = vim.o.laststatus == 3 and 0 or 3
end

-- Qucikfix window
function M.quickfix_toggle()
  local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
  if qf_winid ~= 0 then
    vim.cmd.cclose()
  else
    vim.cmd("botright copen")
  end
end

--- Change the number column between relative and fixed
function M.toggle_number()
  if vim.wo.number then
    vim.wo.relativenumber = not vim.wo.relativenumber
  end
end

-- Change directory
function M.change_root_directory()
  vim.cmd([[lcd%:p:h]])
  vim.notify("Directory changed")
end

-- Enable linting for only these filetypes
function M.lint_filetype()
  return { "python", "htmldjango" }
end

-- Toggle Lsp-Inlay Hint
function M.inlay_hint()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end

return M
